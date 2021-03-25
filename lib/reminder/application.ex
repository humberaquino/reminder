defmodule Reminder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Reminder.Repo,
      # Start the Telemetry supervisor
      ReminderWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Reminder.PubSub},
      # Start the Endpoint (http/https)
      ReminderWeb.Endpoint
      # Start a worker by calling: Reminder.Worker.start_link(arg)
      # {Reminder.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Reminder.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ReminderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
