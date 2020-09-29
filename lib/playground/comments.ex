defmodule Playground.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :raw_text, :string
    belongs_to :author, Playground.User, foreign_key: :author_id
    belongs_to :topic, Playground.Topic, foreign_key: :topic_id
    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:raw_text])
    |> validate_required([:raw_text])
  end
end
