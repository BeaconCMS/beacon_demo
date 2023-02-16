# BeaconCMS Demo

Sample application to showcase [beacon](https://github.com/BeaconCMS/beacon) features and tips. Follow the readme to get started:

#### Run a database

Postgres is configured by default but you may change the adapter in `lib/beacon_demo/repo.ex`.

#### Adjust database connection

In `config/dev.exs` adjust the following repo config to fit your local environment:

```elixir
config :beacon_demo, BeaconDemo.Repo, ...

config :beacon, Beacon.Repo, ...
```

#### Local beacon (optional)

By default it will install the latest version of [beacon](https://github.com/BeaconCMS/beacon) but you can use a local checkout for testing and development:

```sh
git clone git@github.com:BeaconCMS/beacon.git ../beacon
```

And then define the path to your local copy:

```sh
export BEACON_PATH=../beacon
```

#### Change pages (optional)

Layouts and pages are defined in `priv/repo/beacon_seeds.exs`. Feel free to change it but remember to run seeds or reset the database.

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

  * http://localhost:4000/demo/home to see a page with events.
  * http://localhost:4000/blog/posts/2023-01-sample for a demo of dynamic paths.
  * http://localhost:4000/admin to manage sites.

### Exploring

Checkout the [Beacon guides](https://github.com/BeaconCMS/beacon/tree/main/guides) for more.
