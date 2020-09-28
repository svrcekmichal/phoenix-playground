defmodule PlaygroundWeb.SessionController do
  use PlaygroundWeb, :controller

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
