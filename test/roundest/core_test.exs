defmodule Roundest.CoreTest do
  use ExUnit.Case
  alias Roundest.Core
  alias Roundest.Repo

  setup do
    # Set up Ecto sandbox for test isolation
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "get_two_random_pokemon/0" do
    test "returns two different Pokemon" do
      # Get two random Pokemon
      {first, second} = Core.get_two_random_pokemon()

      # Assert we got two different Pokemon
      assert first.id != second.id
    end

    test "returns exactly two Pokemon" do
      random_pokemon = Core.get_two_random_pokemon()
      assert tuple_size(random_pokemon) == 2
    end
  end
end
