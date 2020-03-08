defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias Discuss.Discussion.Topic

  def index(conn, _params) do
    topics = Discuss.Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def create(conn, _params) do
    changeset = Topic.changeset(%Topic{},%{})
    render(conn, "create.html", changeset: changeset)
  end

  def edit(conn,  %{"id" => id}) do
    topic = Discuss.Repo.get(Topic, id)
    render(conn, "edit.html", topic: topic)
  end

  def store(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)
    case Discuss.Repo.insert(changeset) do
      {:ok,_topic} ->
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
end
