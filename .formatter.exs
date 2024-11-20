[
  import_deps: [:ecto, :ecto_sql, :phoenix, :beacon, :beacon_live_admin],
  subdirectories: ["priv/*/migrations"],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  line_length: 150,
  heex_line_length: 150,
  inputs: ["*.{heex,ex,exs}", "{config,lib,test}/**/*.{heex,ex,exs}", "priv/*/seeds.exs"]
]
