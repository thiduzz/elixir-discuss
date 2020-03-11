defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  plug Ueberauth

  alias Discuss.Discussion.User
  alias Discuss.Repo

  @spec callback(%{assings: %{ueberauth_auth: any}}, any) :: nil
  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => social_network_provider} = _params) do
    IO.inspect(auth)
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      name: auth.info.name,
      username: auth.info.nickname,
      profile_picture_url: auth.info.urls.avatar_url,
      provider: social_network_provider
    }
    signin(conn, User.changeset(%User{}, user_params))

  end

  def logout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:error, "Logged out (not yet)")
    |> redirect( to: Routes.topic_path( conn, :index ))
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome #{user.name}!")
        |> put_session(:user_id, user.id)
        |> redirect( to: Routes.topic_path(conn, :index))
      {:error, reason} ->
        conn
        |> put_flash(:error, "Failed to register with #{changeset.changes.provider}")
        |> redirect( to: Routes.topic_path(conn, :index))
    end
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, [email: changeset.changes.email, provider: changeset.changes.provider]) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end


end
