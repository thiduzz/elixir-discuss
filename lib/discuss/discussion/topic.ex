defmodule Discuss.Discussion.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Discussion.User
  alias Discuss.Discussion.Comment

  schema "topics" do
    field :title, :string
    field :type, :string
    timestamps()
    has_many  :comments, Comment
    belongs_to :user, User
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
P
