defmodule Cities.MixProject do
  use Mix.Project

  def project do
    [
      app: :cities,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:xairo, github: "mikowitz/xairo"},
      {:messiaen, "~> 0.1.0", github: "mikowitz/messiaen"},
      # {:dep_from_hexpm, "~> 0.3.0"},
      {:erlport, "~> 0.9"},
      {:satie, github: "mikowitz/satie"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
