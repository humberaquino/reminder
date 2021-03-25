defmodule ReminderWeb.Router do
  use ReminderWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ReminderWeb do
    pipe_through :browser

    get "/", PageController, :root
  end

  scope "/app", ReminderWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/reminders", PageController, :index
    get "/reminders/create", PageController, :index
  end

  scope "/gql" do
    pipe_through :api

    forward "/i", Absinthe.Plug.GraphiQL, schema: ReminderWeb.GraphQL.Schema
    forward "/", Absinthe.Plug, schema: ReminderWeb.GraphQL.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", ReminderWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ReminderWeb.Telemetry
    end
  end
end
