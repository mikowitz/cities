defmodule Cities.Python do
  def call_python(module, function, args \\ []) do
    default_instance()
    |> do_call_python(module, function, args)
  end

  defp default_instance() do
    path =
      [:code.priv_dir(:cities), "python"]
      |> Path.join()

    python_instance(to_charlist(path))
  end

  defp python_instance(path) when is_list(path) do
    {:ok, pid} = :python.start([{:python_path, to_charlist(path)}])
    pid
  end

  defp python_instance(_) do
    {:ok, pid} = :python.start()
    pid
  end

  defp do_call_python(pid, module, function, arguments) do
    pid
    |> :python.call(module, function, arguments)
  end
end
