defmodule OnlineStore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      OnlineStoreWeb.Telemetry,
      OnlineStore.Repo,
      {DNSCluster, query: Application.get_env(:online_store, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OnlineStore.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: OnlineStore.Finch},
      # Start a worker by calling: OnlineStore.Worker.start_link(arg)
      # {OnlineStore.Worker, arg},
      # Start to serve requests, typically the last entry
      OnlineStoreWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OnlineStore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OnlineStoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
