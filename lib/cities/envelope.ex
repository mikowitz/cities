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

    {xs, ys}

    Enum.zip(xs, ys)
    |> Enum.map(&Tuple.to_list/1)
    |> List.flatten()
    |> then(fn points ->
      python = System.find_executable("python3")

      Port.open(
        {:spawn_executable, python},
        args: [
          "./priv/python/spline.py",
          "calculate_spline",
          city,
          "#{total_length}" | Enum.map(points, &to_string/1)
        ]
      )
    end)
  end
end
