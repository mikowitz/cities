defmodule Cities.City do
  def total(city) do
    Cities.read_city(city)
    |> then(fn s ->
      Regex.replace(~r/\s/, s, "")
    end)
    |> Messiaen.lengths()
    |> Enum.sum()
  end

  def build_letter_envelopes(city) do
    for c <- to_charlist(city), do: build_letter_envelope(city, c)
  end

  def build_letter_envelope(city, letter) do
    [{c, _, _} = start | rest] = chars = parse_city_with_word_position(city)

    {a, e} =
      case c do
        ^letter -> {start, rest}
        _ -> {{letter, 0, 0}, chars}
      end

    {xs, ys} =
      Enum.reduce(e, [a], fn {char, len, _gain} = next,
                             [{current_char, current_len, current_gain} | rest] =
                               acc ->
        case char do
          ^current_char -> [next | acc]
          _ -> [{current_char, current_len + len, current_gain} | rest]
        end
      end)
      |> Enum.reverse()
      |> Enum.map(fn {_, b, c} -> {b, c} end)
      |> Enum.unzip()

    xs = Enum.scan(xs, &(&1 + &2)) |> List.insert_at(0, 0)
    ys = List.insert_at(ys, -1, Enum.at(ys, -1))

    File.mkdir_p("priv/text/letter-dynamic-envelope/#{city}/linear")
    File.mkdir_p("priv/text/letter-dynamic-envelope/#{city}/cubic")
    File.mkdir_p("priv/text/letter-dynamic-envelope/#{city}/average")
    File.mkdir_p("priv/images/letter-dynamic-envelope/#{city}")

    Enum.zip(xs, ys)
    |> Enum.map(&Tuple.to_list/1)
    |> List.flatten()
    |> then(fn points ->
      Cities.Python.call_python(
        "./priv/python/spline.py",
        "calculate_letter_spline",
        [city, [letter] | points]
      )
    end)
  end

  def parse_city_with_word_position(city) do
    Cities.read_city(city)
    |> String.split(" ", trim: true)
    |> Enum.map(&parse_word_with_word_position/1)
    |> List.flatten()
  end

  defp parse_word_with_word_position(word) do
    word
    |> to_charlist()
    |> Enum.with_index(1)
    |> Enum.map(fn {c, i} ->
      {c, Messiaen.length(c), i / String.length(word)}
    end)
  end
end
