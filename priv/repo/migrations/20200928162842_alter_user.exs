defmodule Playground.Repo.Migrations.AlterUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :provider, :string
      add :token, :string
      add :email, :string
      timestamps()
    end
  end
end
