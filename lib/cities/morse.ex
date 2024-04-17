defmodule Cities.Morse do
  @symbol_to_length %{?- => 3, ?. => 1}
  @char_to_morse %{
    ?a => ".-",
    ?b => "-...",
    ?c => "-.-.",
    ?d => "-..",
    ?e => ".",
    ?f => "..-.",
    ?g => "--.",
    ?h => "....",
    ?i => "..",
    ?j => ".---",
    ?k => "-.-",
    ?l => ".-..",
    ?m => "--",
    ?n => "-.",
    ?o => "---",
    ?p => ".--.",
    ?q => "--.-",
    ?r => ".-.",
    ?s => "...",
    ?t => "-",
    ?u => "..-",
    ?v => "...-",
    ?w => ".--",
    ?x => "-..-",
    ?y => "-.--",
    ?z => "--.."
  }

  def to_morse(word) do
    word
    |> to_charlist()
    |> Enum.map(&@char_to_morse[&1])
  end

  def to_timespans(word, total \\ 1000) do
    word
    |> to_morse()
    |> Enum.map(&morse_to_count/1)
    |> Enum.intersperse(3)
    |> then(fn l ->
      sum = Enum.sum(l)

      [0 | Enum.scan(l, &(&1 + &2))]
      |> Enum.map(&round(&1 * total / sum))
    end)
  end

  def morse_to_count(morse) do
    morse
    |> to_charlist()
    |> Enum.map(&@symbol_to_length[&1])
    |> Enum.sum()
  end
end
