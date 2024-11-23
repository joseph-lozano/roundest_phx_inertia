defmodule RoundestWeb.ResultsChannel do
  use RoundestWeb, :channel

  @impl true
  def join("results", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl Phoenix.Channel
  def handle_info("update", socket) do
    push(socket, "update", %{})
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
