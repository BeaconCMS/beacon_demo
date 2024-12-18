defmodule BeaconDemo.MixProject do
  use Mix.Project

  @dev? System.get_env("BEACON_DEMO_DEV") in ["true", "1"]

  def project do
    [
      app: :beacon_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      releases: [
        beacon_demo: [
          steps: [:assemble, &copy_beacon_files/1]
        ]
      ]
    ]
  end

  defp copy_beacon_files(%{path: path} = release) do
    case Path.wildcard("_build/tailwind-*") do
      [] ->
        raise """
        tailwind-cli not found

        Execute the following command to install it before proceeding:

            mix tailwind.install

        """

      tailwind_bin_path ->
        build_path = Path.join([path, "bin", "_build"])
        File.mkdir_p!(build_path)

        for file <- tailwind_bin_path do
          File.cp!(file, Path.join(build_path, Path.basename(file)))
        end
    end

    File.cp!(Path.join(["assets", "css", "app.css"]), Path.join(path, "app.css"))

    release
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
      {:igniter, "~> 0.4"},
      {:bandit, "~> 1.5"},
      {:phoenix, "~> 1.7"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, "~> 0.17"},
      {:phoenix_html, "~> 4.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.0"},
      {:phoenix_live_dashboard, "~> 0.7"},
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
      {:live_monaco_editor, "~> 0.1"}
    ]
  end

  defp beacon_dep do
    cond do
      path = System.get_env("BEACON_PATH") ->
        {:beacon, path: path, override: true}

      @dev? ->
        {:beacon, github: "BeaconCMS/beacon", override: true}

      :else ->
        {:beacon, ">= 0.0.0 and < 1.0.0", override: true}
    end
  end

  defp beacon_live_admin_dep do
    cond do
      path = System.get_env("BEACON_LIVE_ADMIN_PATH") ->
        {:beacon_live_admin, path: path}

      @dev? ->
        {:beacon_live_admin, github: "BeaconCMS/beacon_live_admin"}

      :else ->
        {:beacon_live_admin, ">= 0.0.0"}
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
      setup: ["deps.get", "assets.setup", "assets.build", "ecto.setup"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing", "cmd npm install --prefix assets"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "phx.digest"
      ],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds/beacon.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
