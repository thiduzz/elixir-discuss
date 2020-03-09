defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussion.Topic
  alias Discuss.Repo

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def create(conn, _params) do
    changeset = Topic.changeset(%Topic{},%{})
    render(conn, "create.html", changeset: changeset)
  end

  def edit(conn,  %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def store(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created!")
        |> redirect to: Routes.topic_path conn, :index
      {:error, changeset} ->
        render(conn, "create.html", changeset: changeset)
    end

    #conn
    #|> put_status(200)
    #|> halt()
  end

  def update(conn, %{"topic" => topic, "id" => topic_id}) do
    old_topic = Repo.get!(Topic, topic_id)
    changeset = Topic.changeset(old_topic,topic)
    case Repo.update changeset  do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic #{topic_id} updated!")
        |> redirect to: Routes.topic_path conn, :index
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def destroy(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!
    conn
    |> put_flash(:info, "Topic #{topic_id} deleted!")
    |> redirect to: Routes.topic_path conn, :index
  end
end
