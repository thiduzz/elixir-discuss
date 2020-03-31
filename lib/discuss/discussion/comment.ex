defmodule Discuss.Discussion.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Discuss.Discussion.Topic
  alias Discuss.Discussion.User

  @derive {Jason.Encoder, only: [:content, :user, :inserted_at]}

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
