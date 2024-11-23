defmodule Roundest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RoundestWeb.Telemetry,
      Roundest.Repo,
      {DNSCluster, query: Application.get_env(:roundest, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Roundest.PubSub},
      # Start a worker by calling: Roundest.Worker.start_link(arg)
      # {Roundest.Worker, arg},
      {Cachex, [:results_cache]},
      {Inertia.SSR, path: Application.app_dir(:roundest, "priv/")},
      # Start to serve requests, typically the last entry
      RoundestWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Roundest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RoundestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
