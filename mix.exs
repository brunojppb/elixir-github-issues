defmodule Issues.MixProject do
  use Mix.Project

  def project do
    [
      app:              :issues,
      escript:          escript_config(),
      version:          "0.1.0",
      elixir:           "~> 1.10",
      name:             "Issues",
      source_url:       "https://github.com/brunojppb/elixir-github-issues",
      start_permanent:  Mix.env() == :prod,
      deps:             deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      env: [github_url: "https://api.github.com"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.6.2"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.21.3"},
      {:earmark, "~> 1.4.3"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  def escript_config do
    [
      main_module: Issues.CLI
    ]
  end
end
