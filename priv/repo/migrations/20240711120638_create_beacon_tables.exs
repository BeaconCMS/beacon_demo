defmodule BeaconDemo.Repo.Migrations.CreateBeaconTables do
  use Ecto.Migration
  defdelegate up, to: Beacon.Migration
  defdelegate down, to: Beacon.Migration
end
