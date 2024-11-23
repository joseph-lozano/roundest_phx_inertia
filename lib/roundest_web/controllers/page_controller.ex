defmodule RoundestWeb.PageController do
  use RoundestWeb, :controller

  def home(conn, _params) do
    [first, second] = Roundest.Core.get_two_random_pokemon()
    render_inertia(conn, "Home", %{first_pokemon: first, second_pokemon: second})
  end
end
