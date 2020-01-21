defmodule Assert.MixProject do
  use Mix.Project

  def project do
    [
      app: :assert,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:const, git: "https://github.com/nicholasbair/const.git"},
      {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
    ]
  end
end
