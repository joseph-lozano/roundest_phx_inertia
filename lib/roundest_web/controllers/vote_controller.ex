defmodule RoundestWeb.VoteController do
  use RoundestWeb, :controller

  alias Roundest.Core

  def index(conn, _params) do
    render_inertia(conn, "Results", %{"rankings" => Core.get_rankings()})
  end

  def create(conn, params) do
    case Core.cast_vote(params) do
      {:ok, %{winner: %{name: name}}} ->
        conn |> put_flash(:info, "Vote for #{name} recorded") |> redirect(to: "/")

      _ ->
        conn |> put_flash(:error, "Something went wrong") |> redirect(to: "/")
    end
  end
end
