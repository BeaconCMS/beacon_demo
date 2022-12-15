defmodule BeaconDemo.Repo do
  use Ecto.Repo,
    otp_app: :beacon_demo,
    adapter: Ecto.Adapters.Postgres
end
