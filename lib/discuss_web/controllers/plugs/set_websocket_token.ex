defmodule DiscussWeb.Plugs.SetWebsocketToken do
  import Plug.Conn

  alias Discuss.Repo
  alias Discuss.Discussion.User

  def init(_params) do

  end

  def call(conn, _params) do
    if current_user = conn.assigns[:user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

end
