defmodule Example do
  use Mix.Project

  def project do
    [
      app: :example,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Example.Application, []},
      extra_applications: [:membrane_webrtc_server]
    ]
  end

  defp aliases do
    [
      start: "run --no-halt"
    ]
  end

  defp deps do
    [
      {:membrane_webrtc_server, path: "../"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:plug, "~> 1.7"},
      {:plug_cowboy, "~> 2.0"}
    ]
  end
end
