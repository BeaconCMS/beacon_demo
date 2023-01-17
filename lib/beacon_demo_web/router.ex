defmodule BeaconDemoWeb.Router do
  use BeaconDemoWeb, :router
  import Beacon.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BeaconDemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/beacon" do
    pipe_through :browser
    beacon_admin "/admin"
    beacon_site "/", name: "my_site", data_source: BeaconDemo.BeaconDataSource
  end

  scope "/page_management_api" do
    pipe_through :api
    beacon_api "/"
  end
end
