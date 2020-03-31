defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  alias Discuss.Discussion.{Topic, Comment}
  alias Discuss.Repo

  def join("comments:"<> topic_id, _params, socket) do
      topic_id = String.to_integer(topic_id)
      topic = Topic
        |> Repo.get(topic_id)
        |> Repo.preload(comments: [:user])
      {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  @spec handle_in(<<_::64, _::_*8>>, map, atom | %{assigns: atom | %{topic: any}}) ::
          {:reply, :ok | {:error, %{errors: <<>> | map}}, atom | %{assigns: any}}
  def handle_in( "comment:"<> name, %{"content" => content}, socket) do

    topic = socket.assigns.topic
    case name do
      "add" ->
        add_comment(topic,content,socket)
      "remove" ->
        {:reply, {:error, %{errors: ""}}, socket}
    end
  end

  defp add_comment(topic, content, socket) do
    user_id = socket.assigns.current_user
    changeset = topic
    |> Ecto.build_assoc(:comments, user_id: user_id)
    |> Comment.changeset(%{content: content})
    case Repo.insert(changeset) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{topic.id}:store", %{comment: comment})
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}},socket}
    end
  end

end
