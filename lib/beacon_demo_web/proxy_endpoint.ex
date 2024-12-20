defmodule BeaconDemoWeb.ProxyEndpoint do
  @session_options Application.compile_env!(:beacon_demo, :session_options)
  use Beacon.ProxyEndpoint, otp_app: :beacon_demo, session_options: @session_options, fallback: BeaconDemoWeb.Endpoint
end
