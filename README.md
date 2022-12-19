# BeaconCMS Demo

Sample application to demo [BeaconCMS](https://beaconcms.org/) features and tips.

To get started:

#### Install dependencies

It does require Postgres running and you may change the following
config in `config/dev.exs` to adjust connection config:


```elixir
config :beacon_demo, BeaconDemo.Repo, ...

config :beacon, Beacon.Repo, ...
```

#### Setup deps, database, and run the server

_Note that `mix ecto.reset` will delete all the data in those repos._

```bash
mix do deps.get, ecto.reset
```

```bash
mix phx.server
```


#### Demo

Visit http://localhost:4000/beacon/home to see a page built on Beacon or http://localhost:4000/page_management/pages/ to manage existing pages.
