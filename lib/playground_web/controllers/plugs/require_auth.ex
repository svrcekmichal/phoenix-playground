defmodule Playground.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias PlaygroundWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    case user_id do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in")
        |> redirect(to: Helpers.topic_path(conn, :index))
        |> halt()

      _ ->
        conn
    end
  end
end
