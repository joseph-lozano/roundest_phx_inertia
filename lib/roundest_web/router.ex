defmodule RoundestWeb.Router do
  use RoundestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {RoundestWeb.Layouts, :root}
    plug :put_layout, false
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Inertia.Plug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RoundestWeb do
    pipe_through :browser

    get "/", PageController, :home

    post "/vote/:winner_id/:loser_id", VoteController, :create
    get "/results", VoteController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RoundestWeb do
  #   pipe_through :api
  # end
end
