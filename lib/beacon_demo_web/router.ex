defmodule BeaconDemoWeb.Router do
  use BeaconDemoWeb, :router
  require BeaconWeb.Admin
  require BeaconWeb.PageManagementApi

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

  pipeline :beacon do
    plug BeaconWeb.Plug
  end

  scope "/", BeaconDemoWeb do
    pipe_through :browser
  end

  scope "/beacon/admin", BeaconWeb.Admin do
    pipe_through :browser

    BeaconWeb.Admin.routes()
  end

  scope "/", BeaconWeb do
    pipe_through :browser
    pipe_through :beacon

    live_session :beacon, session: %{"beacon_site" => "my_site"} do
      live "/beacon/*path", PageLive, :path
    end
  end

  scope "/page_management_api", BeaconWeb.PageManagementApi do
    pipe_through :api

    BeaconWeb.PageManagementApi.routes()
  end
end
