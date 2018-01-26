defmodule Transform.Mixfile do
  use Mix.Project

  def project do
    [
      app: :transform,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      applications:       [:timex],
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto,           "~> 2.1"},
      {:mix_test_watch, "~> 0.5", only: :dev},
      {:timex,           "~> 3.0"},
    ]
  end
end
