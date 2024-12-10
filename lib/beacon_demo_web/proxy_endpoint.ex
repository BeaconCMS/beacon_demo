defmodule BeaconDemoWeb.ProxyEndpoint do
  use Beacon.ProxyEndpoint, otp_app: :beacon_demo, endpoints: [BeaconDemoWeb.Endpoint]
end
