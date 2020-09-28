defmodule Playground.Repo.Migrations.AddUserAvatar do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :avatar, :string
      add :username, :string
    end
  end
end
