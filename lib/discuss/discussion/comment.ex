defmodule Discuss.Discussion.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Discussion.Topic
  alias Discuss.Discussion.User

  schema "comments" do
    field :content,                         :string
    belongs_to :user,                       User
    belongs_to :topic,                      Topic
    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
P
