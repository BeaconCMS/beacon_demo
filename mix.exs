defmodule BeaconDemo.MixProject do
  use Mix.Project

  @version "0.3.0"

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
    build_path = Path.join([path, "bin", "_build"])
    File.mkdir_p!(build_path)

    copy_bin! = fn name, pattern, cmd ->
      case Path.wildcard(pattern) do
        [] ->
          raise """
          #{name} binary not found in the release package

          You should execute the following command to download it:

              #{cmd}

          Note the binary must be present in the environment where the
          release is generated, either locally or in the Dockerfile for example.

          """

        bin_path ->
          for file <- bin_path do
            File.cp!(file, Path.join(build_path, Path.basename(file)))
          end
      end
    end

    copy_bin!.("tailwind", "_build/tailwind-*", "mix tailwind.install --no-assets")
    copy_bin!.("esbuild", "_build/esbuild-*", "mix esbuild.install")

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
      {:heroicons, github: "tailwindlabs/heroicons", tag: "v2.2.0", sparse: "optimized", app: false, compile: false, depth: 1},
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

      String.ends_with?(@version, "-dev") ->
        {:beacon, github: "BeaconCMS/beacon", override: true}

      :else ->
        {:beacon, ">= 0.0.0 and < 1.0.0", override: true}
    end
  end

  defp beacon_live_admin_dep do
    cond do
      path = System.get_env("BEACON_LIVE_ADMIN_PATH") ->
        {:beacon_live_admin, path: path}

      String.ends_with?(@version, "-dev") ->
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
      "assets.build": [
        "tailwind default",
        "esbuild default",
        "esbuild beacon_tailwind_config"
      ],
      "assets.deploy": [
        "tailwind default --minify",
        "esbuild default --minify",
        "esbuild beacon_tailwind_config --minify",
        "phx.digest"
      ],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds/beacon.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
