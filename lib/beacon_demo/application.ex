defmodule BeaconDemo.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BeaconDemoWeb.Telemetry,
      # Start the Ecto repository
      BeaconDemo.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: BeaconDemo.PubSub},
      # Start Finch
      {Finch, name: BeaconDemo.Finch},
      # Start the Endpoint (http/https)
      BeaconDemoWeb.Endpoint,
      BeaconDemoWeb.EndpointSite,
      BeaconDemoWeb.ProxyEndpoint,
      # Start Beacon sites
      {Beacon, [sites: [Application.fetch_env!(:beacon, :demo)]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BeaconDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BeaconDemoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
