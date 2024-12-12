defmodule BeaconDemoWeb.ProxyEndpoint do
  use Beacon.ProxyEndpoint,
    otp_app: :beacon_demo,
    session_options: Application.compile_env!(:beacon_demo, :endpoint)[:session_options],
    fallback: BeaconDemoWeb.Endpoint
end
