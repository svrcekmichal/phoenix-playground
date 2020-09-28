defmodule Playground.Repo.Migrations.ConnectTopicToUser do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :user_id, references(:users), null: false
    end
  end
end
