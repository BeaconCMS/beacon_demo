defmodule BeaconDemo.Repo.Migrations.UpdateBeaconV002 do
  use Ecto.Migration
  def up, do: Beacon.Migration.up()
  def down, do: Beacon.Migration.down()
end
