defmodule PlaygroundWeb.AuthController do
  use PlaygroundWeb, :controller
  alias Playground.User
  plug Ueberauth

  def callback(conn, params) do
    make_changeset(conn, params)
    |> upsert_user
    |> handle_sign_in(conn)
  end

  defp make_changeset(%{ assigns: %{ ueberauth_auth: auth } }, %{ "provider" => provider }) do
    User.changeset(%User{}, %{
      name: auth.info.name,
      username: auth.info.nickname,
      email: auth.info.email,
      avatar: auth.info.urls.avatar_url,
      token: auth.credentials.token,
      provider: provider
    })
  end

  defp upsert_user(changeset) do
    Playground.Repo.insert(changeset, on_conflict: { :replace, [:name, :token, :avatar] }, conflict_target: :username)
  end

  defp handle_sign_in({ :ok, user }, conn) do
    conn
      |> put_flash(:info, "You've been logged in")
      |> put_session(:user_id, user.id)
      |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp handle_sign_in({:err, _}, conn) do
    conn
      |> put_flash(:error, "Error signing in")
      |> redirect(to: Routes.topic_path(conn, :index))
  end
end
