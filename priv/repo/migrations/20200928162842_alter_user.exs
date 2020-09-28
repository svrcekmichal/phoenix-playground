defmodule Playground.Repo.Migrations.AlterUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :provider, :string
      add :token, :string
    end
  end
end
