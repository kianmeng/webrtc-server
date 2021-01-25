defmodule Membrane.WebRTC.Server.MixProject do
  use Mix.Project

  @version "0.1.0"
  @github_url "https://github.com/membraneframework/webrtc-server"

  def project do
    [
      app: :membrane_webrtc_server,
      aliases: [docs: ["docs", &copy_images/1]],
      name: "WebRTC Server",
      description: "Membrane Multimedia Framework (WebRTC signaling server)",
      version: @version,
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: @github_url,
      package: package(),
      docs: docs()
    ]
  end

  defp deps do
    [
      {:uuid, "1.1.8"},
      {:cowboy, "2.8.0"},
      {:jason, "1.2.2"},
      {:dialyxir, "1.0.0", only: [:dev], runtime: false},
      {:credo, "1.5.4", only: [:dev, :test], runtime: false},
      {:bimap, "1.1.0"},
      {:ex_doc, "0.23.0", only: :dev, runtime: false},
      {:bunch, "1.3.0"}
    ]
  end

  def docs do
    [
      main: "readme",
      extras: [
        "README.md",
        "pages/Guide.md"
      ],
      nest_modules_by_prefix: [
        Membrane.WebRTC.Server
      ],
      groups_for_modules: [
        Peer: [~r/^Membrane.WebRTC.Server.Peer.*/],
        Room: [~r/^Membrane.WebRTC.Server.Room.*/],
        Message: [~r/^Membrane.WebRTC.Server.Message.*/]
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Membrane Team"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => @github_url,
        "Membrane Framework Homepage" => "https://membraneframework.org"
      }
    ]
  end

  def application do
    [
      mod: {Membrane.WebRTC.Server, []},
      extra_applications: []
    ]
  end

  defp copy_images(_) do
    File.cp_r("assets", "doc/assets", fn _source, _destination -> true end)
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_env), do: ["lib"]
end
