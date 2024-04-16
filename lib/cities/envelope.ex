defmodule Cities.Envelope do
  def make(city) do
    total_length = Cities.City.total(city)
    xs = Messiaen.lengths(city) |> Enum.scan(&(&1 + &2)) |> List.insert_at(0, 0)

    ys =
      to_charlist(city)
      |> Enum.map(&(&1 - ?`))
      |> then(fn l ->
        List.insert_at(l, -1, Enum.at(l, 0))
      end)

    Enum.zip(xs, ys)
    |> Enum.map(&Tuple.to_list/1)
    |> List.flatten()
    |> then(fn points ->
      Cities.Python.call_python(
        :spline,
        :calculate_spline,
        [city, total_length, points]
      )
    end)
  end
end
