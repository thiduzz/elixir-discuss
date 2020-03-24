defmodule Discuss.Repo.Migrations.CreateCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content,   :string
      add :topic_id,  references(:topics)
      add :user_id,   references(:users)
      timestamps()
    end
  end
end
