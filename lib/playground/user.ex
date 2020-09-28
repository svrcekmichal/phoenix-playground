defmodule Playground.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :provider, :string
    field :token, :string
    field :avatar, :string
    has_many :topics, Playground.Topic, foreign_key: :user_id
    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :username, :email, :provider, :token, :avatar])
    |> validate_required([:name, :provider])
    |> unique_constraint(:username)
  end
end
