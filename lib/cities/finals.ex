defmodule Cities.Finals do
  defstruct [:letter, :data]

  def load_all_files(city) do
    city_name = city

    [city, letters] = [
      Path.join(text_dir(), "final-city-dynamic-envelope/#{city}.txt"),
      Path.wildcard(Path.join(text_dir(), "letter-dynamic-envelope/#{city}/average/*.txt"))
    ]

    city = read_lines(city)
    letters = Enum.map(letters, fn x -> {x, read_lines(x)} end)

    letters =
      Enum.map(letters, fn {l, coll} -> {l, Enum.zip(city, coll)} end)
      |> Enum.map(fn {l, letter} ->
        # {l, Enum.map(letter, fn {a, b} -> Float.round(a * b, 3) end)}
        %__MODULE__{
          letter: Path.basename(Path.rootname(l)),
          data: Enum.map(letter, fn {a, b} -> Float.round(a * b, 3) end)
        }
      end)

    {min, max} =
      Enum.map(letters, & &1.data)
      |> List.flatten()
      |> Enum.min_max()

    # new_max = 1 / length(letters)

    # {{min, max}, {0, new_max}}

    letters =
      letters
      |> Enum.map(fn l ->
        %{l | data: Enum.map(l.data, &lerp(&1, min, max, 0, 1))}
      end)

    File.mkdir_p("priv/text/final/#{city_name}")

    Enum.map(letters, fn l ->
      File.open("priv/text/final/#{city_name}/#{l.letter}.txt", [:write], fn file ->
        IO.write(file, Enum.join(l.data, "\n"))
      end)
    end)
  end

  def for_max(city_name) do
    File.mkdir_p("priv/text/final/#{city_name}/max")

    files = Path.wildcard(Path.join(text_dir(), "final/#{city_name}/*.txt"))

    Enum.each(files, fn f ->
      data =
        File.read!(f)
        |> String.split("\n", trim: true)
        |> Enum.map(&Float.parse/1)
        |> Enum.map(&elem(&1, 0))

      letter = Path.basename(Path.rootname(f))

      File.open("priv/text/final/#{city_name}/max/#{letter}.txt", [:write], fn outfile ->
        data =
          Enum.with_index(data, 1)
          |> Enum.map(fn {d, i} -> "#{i}, #{Float.round(d, 3)};" end)
          |> Enum.join("\n")

        IO.write(outfile, data)
      end)
    end)
  end

  defp text_dir do
    Path.join(File.cwd!(), "priv/text")
  end

  defp read_lines(filename) do
    File.read!(filename)
    |> String.split("\n", trim: true)
    |> Enum.map(&Float.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  defp lerp(n, a1, z1, a2, z2) do
    a2 + (z2 - a2) / (z1 - a1) * (n - a1)
  end
end
