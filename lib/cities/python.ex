defmodule Cities.Python do
  def call_python(file, function, args) do
    python = System.find_executable("python3")

    port =
      Port.open(
        {:spawn_executable, python},
        args: [file, function | Enum.map(args, &to_string/1)]
      )

    Port.close(port)
  end
end
