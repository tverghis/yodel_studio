defmodule YodelStudio.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      YodelStudioWeb.Telemetry,
      YodelStudio.Repo,
      YodelStudio.ViewCounter.Server,
      {DNSCluster, query: Application.get_env(:yodel_studio, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: YodelStudio.PubSub},
      # Start a worker by calling: YodelStudio.Worker.start_link(arg)
      # {YodelStudio.Worker, arg},
      # Start to serve requests, typically the last entry
      YodelStudioWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: YodelStudio.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YodelStudioWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
