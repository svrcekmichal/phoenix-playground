defmodule PlaygroundWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "comments:*", PlaygroundWeb.CommentsChannel

  @impl true
  def connect(_params, socket, _connect_info) do
    socket = socket
    |> assign(:user, %{ name: "michal" })
    {:ok, socket}
  end


  @impl true
  def id(_socket), do: nil


end
