defmodule Cities.Python do
  def call_python(file, function, args) do
    python = System.find_executable("python3")

    port =
      Port.open(
        {:spawn_executable, python},
        args: [file, function | Enum.map(args, &arg_to_string/1)]
      )

    Port.close(port)
  end

  def arg_to_string(l) when is_list(l) do
    Enum.map(l, &to_string/1)
  end

  def arg_to_string(x), do: to_string(x)
end
