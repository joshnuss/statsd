defmodule StatsD.Mixfile do
  use Mix.Project

  def project do
    [app: :statsd,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {StatsD.Application, []}]
  end

  defp aliases do
    [test: "test --no-start"]
  end

  defp deps do
    []
  end
end
