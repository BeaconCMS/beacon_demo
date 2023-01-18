defmodule BeaconDemo.BeaconDataSource do
  @behaviour Beacon.DataSource.Behaviour

  def live_data("demo", ["home"], _params), do: %{vals: ["first", "second", "third"]}

  def live_data("blog", ["posts", post_slug], _params),
    do: %{post_slug_uppercase: String.upcase(post_slug)}

  def live_data(_, _, _), do: %{}
end
