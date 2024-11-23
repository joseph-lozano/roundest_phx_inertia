defmodule RoundestWeb.PageController do
  use RoundestWeb, :controller

  def home(conn, _params) do
    first = get_session(conn, :first)
    second = get_session(conn, :second)

    {first, second, next_first, next_second} =
      cond do
        Enum.any?([first, second], &is_nil/1) ->
          {first, second} = Roundest.Core.get_two_random_pokemon()
          {next_first, next_second} = Roundest.Core.get_two_random_pokemon()
          {first, second, next_first, next_second}

        true ->
          {next_first, next_second} = Roundest.Core.get_two_random_pokemon()
          {first, second, next_first, next_second}
      end

    conn
    |> put_session(:first, first)
    |> put_session(:second, second)
    |> put_session(:next_first, next_first)
    |> put_session(:next_second, next_second)
    |> assign_prop(:first_pokemon, first)
    |> assign_prop(:second_pokemon, second)
    |> assign_prop(:next_first, next_first)
    |> assign_prop(:next_second, next_second)
    |> render_inertia("Home")
  end
end
