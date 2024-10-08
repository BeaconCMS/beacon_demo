# BeaconCMS Demo

Sample application to showcase [beacon](https://github.com/BeaconCMS/beacon) features. Follow the readme to get started:

## Local

#### Run a database

Postgres is configured by default but you may change the adapter in `lib/beacon_demo/repo.ex`.

#### Adjust database connection

In `config/dev.exs` adjust the following repo config to fit your local environment:

```elixir
config :beacon_demo, BeaconDemo.Repo, ...
```

#### Setup

Run setup to install dependencies and setup initial data:

```sh
mix setup
```

#### Run server

```sh
mix phx.server
```

#### Change seeds data (optional)

Layouts and pages are defined in `priv/repo/seeds/beacon.exs`.  That data will be seeded on `mix setup` and you can manage it using the admin interface,
but feel free to edit as you wish and run `mix ecto.reset` to drop the database and recreate all data.

### Demo

Visit some sample pages:

  * http://localhost:4000 to see an example of a landing page.
  * http://localhost:4000/blog to visit the blog index.
  * http://localhost:4000/admin to manage your demo site.

## Deploy to Fly.io

1. Install [flyctl](https://github.com/superfly/flyctl)
2. Execute `fly auth login` to authenticate with your Fly.io account
3. Execute `fly launch` to create and deploy a new application. Answer `y` when asked to copy existing configuration.

## Exploring

Checkout the [Beacon guides](https://github.com/BeaconCMS/beacon/tree/main/guides) for more.
