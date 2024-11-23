defmodule RoundestWeb.PageController do
  use RoundestWeb, :controller

  def home(conn, _params) do
    render_inertia(conn, "Home")
  end
end
