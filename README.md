# BeaconCMS Demo

Sample application to demo [beacon](https://github.com/BeaconCMS/beacon) features and tips. To get started:

#### Run a database

Postgres is configured by default but you may change the adapter in `lib/beacon_demo/repo.ex`.

#### Adjust database connection

In `config/dev.exs` adjust the following repo config to fit your local environment:

```elixir
config :beacon_demo, BeaconDemo.Repo, ...

config :beacon, Beacon.Repo, ...
```

#### Setup beacon (optional)

By default it will install the latest version of [beacon](https://github.com/BeaconCMS/beacon) but you can use a local checkout for testing and development:

```sh
git clone git@github.com:BeaconCMS/beacon.git ../beacon
```

And then define the path to your local copy:

```sh
export BEACON_PATH=../beacon
```

#### Change pages (optional)

Layouts and pages are defined in `priv/repo/seeds.exs`. Feel free to change it but remember to run seeds or reset the database.

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

Visit http://localhost:4000/beacon/home to see a page built on Beacon or http://localhost:4000/beacon/page_management/pages/ to manage existing pages.
