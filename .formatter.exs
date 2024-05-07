[
  import_deps: [:ecto, :ecto_sql, :phoenix, :beacon, :beacon_live_admin],
  subdirectories: ["priv/*/migrations", "priv/repo/seeds"],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"]
]
