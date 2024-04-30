# BeaconCMS Demo

Sample application to showcase [beacon](https://github.com/BeaconCMS/beacon) features. Follow the readme to get started:

#### Run a database

Postgres is configured by default but you may change the adapter in `lib/beacon_demo/repo.ex`.

#### Adjust database connection

In `config/dev.exs` adjust the following repo config to fit your local environment:

```elixir
config :beacon_demo, BeaconDemo.Repo, ...

config :beacon, Beacon.Repo, ...
```

#### Install dependencies
Beacon depends on C libraries. If deps compilation fails, make sure your environment has the compilers installed. On Ubuntu look for the `build_essential` package, on macOS install utilities with `xcode-select --install`.

#### Change seeds data (optional)

Layouts and pages are defined in `priv/repo/beacon_seeds.exs`. Feel free to change it but remember to reset the database: `mix ecto.reset`

#### Setup

Run:

```sh
mix setup
```

#### Run server

```sh
mix phx.server
```

### Demo

Visit some sample pages:

  * [http://localhost:4000/demo/home](http://localhost:4000/demo/) to see a page with live data.
  * [http://localhost:4000/blog/posts/2023-01-sample](http://localhost:4000/blog/posts/2023-01-sample) for a demo of dynamic paths.
  * [http://localhost:4000/admin](http://localhost:4000/admin) to manage sites.

### Exploring

Checkout the [Beacon guides](https://github.com/BeaconCMS/beacon/tree/main/guides) for more.
