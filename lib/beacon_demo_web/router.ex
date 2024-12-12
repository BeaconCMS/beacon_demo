defmodule BeaconDemoWeb.Router do
  use BeaconDemoWeb, :router
  use Beacon.Router
  use Beacon.LiveAdmin.Router
  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BeaconDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :beacon do
    plug Beacon.Plug
  end

  pipeline :beacon_admin do
    plug Beacon.LiveAdmin.Plug
  end

  scope "/admin" do
    pipe_through [:browser, :beacon_admin]
    beacon_live_admin "/"
  end

  scope "/" do
    pipe_through [:browser]
    live_dashboard "/dashboard"
  end

  # must match the custom endpoint host (domain)
  # and also localhost for local development
  scope "/", host: ["localhost", "beacon-test.me"] do
    pipe_through [:browser, :beacon]
    beacon_site "/", site: :demo
  end
end
