defmodule BeaconDemo.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :beacon_demo

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def beacon_seeds do
    load_app()

    {:ok, _, _} =
      Ecto.Migrator.with_repo(Beacon.Repo, fn _repo ->
        seeds_path = Path.join([:code.priv_dir(@app), "repo", "beacon_seeds.exs"])
        Code.eval_file(seeds_path)
      end)
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
