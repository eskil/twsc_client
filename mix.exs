defmodule TwscClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :twsc_client,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: TwscCli],
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
      {:httpotion, "~> 3.0"},
      {:poison, "~> 3.1"},
      {:timex, "~> 3.0"},
      {:tzdata, "~> 0.1.8"}
    ]
  end
end
