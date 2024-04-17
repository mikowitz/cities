defmodule Cities.CityTimespan do
  alias Satie.{Timespan, TimespanList}

  def morse(city, set) do
    total = Cities.City.total(city)

    city =
      Cities.Morse.to_timespans(city, total)
      |> Enum.chunk_every(2)
      |> Enum.map(&apply(Timespan, :new, &1))

    set =
      Cities.Morse.to_timespans(set, total)
      |> Enum.chunk_every(2)
      |> Enum.map(&apply(Timespan, :new, &1))

    # {
    #   TimespanList.new(city),
    #   TimespanList.new(set)
    # }
    TimespanList.new(city ++ set)
  end

  def build(city, set) do
    city =
      Messiaen.lengths(city)
      |> Enum.intersperse(4)

    city_sum = Enum.sum(city)

    set =
      Messiaen.lengths(set)
      |> Enum.intersperse(4)

    set_sum = Enum.sum(set)

    city =
      Enum.map(city, &(&1 * set_sum))
      |> List.insert_at(0, 0)
      |> Enum.scan(&(&1 + &2))
      |> Enum.chunk_every(2)
      |> Enum.map(&apply(Timespan, :new, &1))

    set =
      Enum.map(set, &(&1 * city_sum))
      |> List.insert_at(0, 0)
      |> Enum.scan(&(&1 + &2))
      |> Enum.chunk_every(2)
      |> Enum.map(&apply(Timespan, :new, &1))

    TimespanList.new(city ++ set)
  end

  def for(city) do
    city_name = city
    set = Cities.set_for(city)

    find_overlap(city, set)
  end

  def find_overlap(city, set) do
    city_name = city
    total = Cities.City.total(city)

    city =
      Cities.Morse.to_timespans(city, total)
      |> Enum.chunk_every(2)
      |> Enum.map(&apply(Timespan, :new, &1))

    set =
      Cities.Morse.to_timespans(set, total)
      |> Enum.chunk_every(2)
      |> Enum.map(&apply(Timespan, :new, &1))

    Enum.map(1..total, fn i ->
      Enum.any?(city, fn ts ->
        [start, stop] = Satie.Timespan.to_float_pair(ts)
        start <= i && i <= stop
      end) &&
        Enum.any?(set, fn ts ->
          [start, stop] = Satie.Timespan.to_float_pair(ts)
          start <= i && i <= stop
        end)
    end)
    |> Enum.with_index(1)
    |> Enum.chunk_by(&elem(&1, 0))
    |> Enum.filter(fn [{x, _} | _] -> x end)
    |> Enum.map(&{List.first(&1), List.last(&1)})
    |> List.update_at(0, fn {{x, _}, y} -> {{x, 0}, y} end)
    |> Enum.map(fn {{_, x}, {_, y}} -> Timespan.new(x, y) end)
    |> TimespanList.new()
    |> Satie.Lilypond.LilypondFile.from()
    |> Satie.Lilypond.LilypondFile.save("priv/images/city-set-timespans/#{city_name}.ly")
  end
end