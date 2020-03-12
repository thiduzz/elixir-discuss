defmodule Discuss.Discussion.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name,                        :string
    field :email,                       :string
    field :password,                    :string
    field :provider,                    :string
    field :username,                    :string
    field :token,                       :string
    field :profile_picture_url,         :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:name, :email, :token, :provider, :username, :profile_picture_url])
    |> validate_required([:name, :token, :provider, :username])
  end
end
P