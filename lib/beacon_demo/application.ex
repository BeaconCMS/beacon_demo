defmodule BeaconDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
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
      # Start Beacon sites
      {Beacon,
       sites: [
         [
           site: :demo,
           endpoint: BeaconDemoWeb.Endpoint,
           extra_page_fields: [
             BeaconDemo.Beacon.PageFields.Type
           ]
         ]
       ]},
      # Start the Endpoint (http/https)
      BeaconDemoWeb.Endpoint
      # Start a worker by calling: BeaconDemo.Worker.start_link(arg)
      # {BeaconDemo.Worker, arg}
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
