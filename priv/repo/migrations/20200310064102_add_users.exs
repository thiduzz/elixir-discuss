defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration


  def up do
    create table(:users) do
      add :name,                        :string
      add :email,                       :string
      add :password,                    :string
      add :provider,                    :string
      add :username,                    :string
      add :token,                       :string
      add :profile_picture_url,         :string
      timestamps()
    end
  end

  def down do
    drop table(:users)
  end
end
