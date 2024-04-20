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
    set = Cities.set_for(city)

    find_overlap(city, set)
    |> save_timespans(city)
  end

  def build_envelope(city) do
    set = Cities.set_for(city)

    xs = Messiaen.lengths(city) |> Enum.scan(&(&1 + &2)) |> List.insert_at(0, 0)

    ys =
      to_charlist(city)
      |> Enum.map(&(&1 - ?`))
      |> then(fn l ->
        List.insert_at(l, -1, Enum.at(l, 0))
      end)

    city_dynamic_envelope =
      Enum.zip(xs, ys)
      |> Enum.map(&Tuple.to_list/1)
      |> List.flatten()

    indices =
      find_overlap(city, set)
      |> Enum.map(fn {{_, a}, {_, b}} -> [a, b] end)
      |> List.flatten()

    # {city_dynamic_envelope, indices}

    Cities.Python.call_python(
      "./priv/python/spline.py",
      "city_set_envelope",
      [city, length(indices) | indices] ++ city_dynamic_envelope
    )
  end

  def find_overlap(city, set) do
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
  end

  def save_timespans(timespans, city_name) do
    timespans
    |> Enum.map(fn {{_, x}, {_, y}} -> Timespan.new(x, y) end)
    |> TimespanList.new()
    |> Satie.Lilypond.LilypondFile.from()
    |> Satie.Lilypond.LilypondFile.save("priv/images/city-set-timespans/#{city_name}.ly")
  end
end
