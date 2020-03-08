defmodule Discuss.Repo.Migrations.AddTopicsTable do
  use Ecto.Migration

    def up do
      create table(:topics) do
        add :title,   :string
        add :type,     :string
        timestamps()
      end
    end

    def down do
      drop table(:topics)
    end
end
