defmodule Cities do
  def read_city(name) do
    File.read!("priv/calvino/#{name}.txt")
    |> String.trim()
    |> String.downcase()
    |> then(fn s ->
      Regex.replace(~r/[":;,.\-'!?\(\)]/, s, "")
    end)
  end

  def parse_city_with_word_position(name) do
    name_chars = to_charlist(name)

    name
    |> read_city()
    |> to_charlist()
    |> Enum.chunk_by(&(&1 != ?\s))
    |> Enum.reject(&(&1 == ' '))
    |> Enum.map(fn word ->
      l = length(word)

      word
      |> Enum.with_index(1)
      |> Enum.map(fn {c, i} -> {[c], i / l} end)
    end)
    |> List.flatten()
    |> Enum.map(fn {[c] = ch, word_position} ->
      {ch, Messiaen.length(c), word_position, c in name_chars}
    end)

    # |> Enum.map(&{[&1], Messiaen.length(&1), &1 in name_chars})

    # |> Enum.map(&{[&1], Messiaen.length(&1), &1 in name_chars})
  end

  def parse_city(name) do
    name_chars = to_charlist(name)

    name
    |> read_city()
    |> to_charlist()
    |> Enum.map(&{[&1], Messiaen.length(&1), &1 in name_chars})
  end

  def map_letter(name, letter) do
    prime_limit =
      case factors_for(letter - ?`) do
        [] -> 2
        factors -> Enum.max(factors)
      end

    parsed = parse_city_with_word_position(name)

    Enum.reduce(parsed, [{letter, 0, 0}], fn {[char], ct, pos, _},
                                             [{_, current_ct, current_pos} | rest] = acc ->
      case char do
        ^letter -> [{[letter], ct, pos} | acc]
        _ -> [{[letter], current_ct + ct, current_pos} | rest]
      end
    end)
    |> Enum.reverse()
    |> then(&[{[letter], 0, 0} | &1])
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [{_, start_time, start_gain}, {_, stop_delta, stop_gain}] ->
      [stop_delta * 100.0, start_gain / prime_limit, stop_gain / prime_limit]
    end)
  end

  defp chuck_body(freq) do
    pan = 2 * (freq / 2700) - 1
    IO.puts(pan)

    """
    ] @=> float fades[][];

    Gain g => dac;
    0.0 => g.gain;

    SinOsc s => Pan2 p => g;
    #{Float.round(pan, 2)} => p.pan;
    #{freq}.0 => s.freq;

    for (0 => int i; i < fades.size(); i++) {
    fades[i][0] => float totalMs;
    fades[i][1] => float startGain;
    fades[i][2] => float stopGain;

    totalMs::ms + now => time stopTime;

    0 => float progress;

    (stopGain - startGain) * (1 / totalMs) => float stepChange;

    while ( now < stopTime ) {
      1 +=> progress;
      stepChange + g.gain() => g.gain;
      1::ms => now;
    }
    }

    s =< g;
    """
  end

  def write_chuck_files(name) do
    IO.inspect(name)
    File.mkdir_p("priv/ck/#{name}")

    for l <- ?a..?z, do: write_chuck_file(name, l)
  end

  def write_chuck_file(name, letter) do
    mappings = map_letter(name, letter)

    File.open("priv/ck/#{name}/#{[letter]}.ck", [:write], fn file ->
      IO.write(file, "[\n")
      Enum.each(mappings, fn m -> IO.write(file, "  #{inspect(m)},\n") end)
      IO.write(file, chuck_body((letter - ?`) * 100))
    end)
  end

  def factors_for(n) do
    Stream.resource(
      fn -> {n, 2} end,
      fn
        {1, _} -> {:halt, nil}
        {acc, prime} when prime * prime > acc -> {[acc], {1, acc}}
        {acc, prime} when rem(acc, prime) == 0 -> {[prime], {div(acc, prime), prime}}
        {acc, 2} -> {[], {acc, 3}}
        # {acc, prime} when rem(prime, 30) in [1, 23] -> {[], {acc, prime + 6}}
        # {acc, prime} when rem(prime, 30) in [7, 13, 19] -> {[], {acc, prime + 4}}
        {acc, prime} -> {[], {acc, prime + 2}}
      end,
      fn _ -> nil end
    )
    |> Enum.to_list()
  end
end
