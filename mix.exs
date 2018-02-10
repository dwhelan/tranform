defmodule Transform.Mixfile do
  use Mix.Project

  def project do
    [
      app: :transform,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  def application do
    [
      applications:       [:timex, :ex_cldr],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_cldr,         "== 1.3.2"},
      {:ex_cldr_numbers, "~> 1.0"},
      {:ecto,            "~> 2.1"},
      {:mix_test_watch,  "~> 0.5", only: :dev},
      {:timex,           "~> 3.0"},
      {:excoveralls,     "~> 0.8", only: :test},
    ]
  end
end
