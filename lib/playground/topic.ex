defmodule Playground.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
    field :description, :string
    belongs_to :user, Playground.User, foreign_key: :user_id
    has_many :comments, Playground.Comment, foreign_key: :topic_id
    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
    |> unsafe_validate_unique([:title], Playground.Repo)
  end
end
