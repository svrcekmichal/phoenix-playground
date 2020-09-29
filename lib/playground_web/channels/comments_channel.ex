defmodule PlaygroundWeb.CommentsChannel do
  use PlaygroundWeb, :channel

  def join("comments:join", _message, socket) do
    map = %{ test: "abc" }
    {:ok, map, socket}
  end

  def join("comments:" <> topic_id, _message, socket) do
    IO.inspect(socket.assigns)
    IO.inspect Playground.Repo.get_by(Playground.Comment, topic_id: topic_id)
    {:ok, socket}
  end

  def join(_channel, _message, socket) do
    {:ok, socket}
  end
end
