defmodule BeaconDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :beacon_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {BeaconDemo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      beacon_dep(),
      beacon_live_admin_dep(),
      {:phoenix, "~> 1.7"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, "~> 0.17"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.19"},
      {:heroicons, github: "tailwindlabs/heroicons", tag: "v2.1.1", sparse: "optimized", app: false, compile: false, depth: 1},
      {:floki, ">= 0.30.0"},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:live_monaco_editor, "~> 0.1"}
    ]
  end

  defp beacon_dep do
    if path = System.get_env("BEACON_PATH") do
      {:beacon, path: path, override: true}
    else
      {:beacon, github: "BeaconCMS/beacon", ref: "ffbfb3d80574e7528d3aa47f5e8eda90813c8d0b", depth: 1, override: true}
    end
  end

  defp beacon_live_admin_dep do
    if path = System.get_env("BEACON_LIVE_ADMIN_PATH") do
      {:beacon_live_admin, path: path}
    else
      {:beacon_live_admin, github: "BeaconCMS/beacon_live_admin", depth: 1, ref: "9e31e0e307cf5ad44be50c689a472905c976bff3"}
    end
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "ecto.setup"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds/beacon.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "esbuild tailwind_config", "phx.digest"]
    ]
  end
end
