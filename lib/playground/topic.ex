defmodule Playground.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
    field :description, :string
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
