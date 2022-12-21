# BeaconCMS Demo

Sample application to demo [beacon](https://github.com/BeaconCMS/beacon) features and tips.

To get started:

#### Install dependencies

It does require Postgres running and you may change the following
config in `config/dev.exs` to adjust connection config:


```elixir
config :beacon_demo, BeaconDemo.Repo, ...

config :beacon, Beacon.Repo, ...
```

#### Setup beacon

By default it will install the latest version of [beacon](https://github.com/BeaconCMS/beacon) but you can use a local checkout for testing and development:

```sh
git clone git@github.com:BeaconCMS/beacon.git ../beacon
```

And then define the path to your local copy:

```sh
export BEACON_PATH=../beacon
```

#### Setup deps and database

_Note that `mix ecto.reset` will delete all the data in those repos._

```sh
mix deps.get
mix ecto.reset
```

#### Run server

```sh
mix phx.server
```

### Demo

Visit http://localhost:4000/beacon/home to see a page built on Beacon or http://localhost:4000/beacon/admin/pages/ to manage existing pages.
