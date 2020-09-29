defmodule Playground.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :raw_text, :string
      add :author_id, references(:users), null: false
      add :topic_id, references(:topics), null: false
      timestamps()
    end
  end
end
