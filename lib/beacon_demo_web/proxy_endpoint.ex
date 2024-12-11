defmodule BeaconDemoWeb.ProxyEndpoint do
  use Beacon.ProxyEndpoint, otp_app: :beacon_demo, endpoints: [BeaconDemoWeb.Endpoint], fallback: BeaconDemoWeb.Endpoint

  plug :debug

  def debug(conn, _opts) do
    dbg(conn.host)
    conn
  end
end
