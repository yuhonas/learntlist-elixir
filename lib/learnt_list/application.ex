defmodule LearntList.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      LearntList.Repo,
      # Start the Telemetry supervisor
      LearntListWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LearntList.PubSub},
      # Start the Endpoint (http/https)
      LearntListWeb.Endpoint
      # Start a worker by calling: LearntList.Worker.start_link(arg)
      # {LearntList.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LearntList.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LearntListWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
