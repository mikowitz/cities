defmodule Cities.Max do
  def city_dynamic_to_max(city) do
    Path.join("priv/text/final-city-dynamic-envelope", "#{city}.txt")
    |> text_to_max()
  end

  def text_to_max(file) do
    new_dir = Path.join(Path.dirname(file), "max")

    File.mkdir_p(new_dir)

    data =
      File.read!(file)
      |> String.split("\n", trim: true)
      |> List.insert_at(-1, 99999)
      |> Enum.with_index(1)
      |> Enum.map(fn {d, i} -> "#{i}, #{d};" end)
      |> Enum.join("\n")

    new_filepath = Path.join(new_dir, Path.basename(file))

    File.write!(new_filepath, data)
  end
end
