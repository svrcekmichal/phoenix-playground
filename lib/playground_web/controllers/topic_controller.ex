defmodule PlaygroundWeb.TopicController do
  use PlaygroundWeb, :controller

  alias Playground.Topic

  plug :put_layout, "topics.html"
  plug Playground.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :require_topic_owner when action in [:edit, :update, :delete]

  def index(conn, _params) do
    topics = Playground.Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def show(conn, %{"id" => topic_id}) do
    case Playground.Repo.get(Topic, topic_id) do
      nil ->
        conn
        |> put_flash(:error, "Topic doesn't exist")
        |> redirect(to: Routes.topic_path(conn, :index))
      topic ->
        render(conn, "show.html", topic: topic)
    end
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic}) do
    changeset =
      conn.assigns[:user]
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    case Playground.Repo.insert(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic \"#{topic.title}\" Created")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Playground.Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"topic" => topic, "id" => topic_id}) do
    original_topic = Playground.Repo.get(Topic, topic_id)
    changeset = Topic.changeset(original_topic, topic)

    case Playground.Repo.update(changeset) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic \"#{topic.title}\" Updated")
        |> redirect(to: Routes.topic_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> render("edit.html", changeset: changeset, topic: original_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    topic = Playground.Repo.get!(Topic, topic_id) |> Playground.Repo.delete!()

    conn
    |> put_flash(:info, "Topic \"#{topic.title}\" Deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  def require_topic_owner(conn, _params) do
    %{ params: %{ "id" => topic_id } } = conn
    if  Playground.Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "Action allowed only to owner")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end
