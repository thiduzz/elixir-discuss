defmodule DiscussWeb.Router do
  use DiscussWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug DiscussWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussWeb do
    pipe_through :browser

    get "/topics", TopicController, :index
    get "/topics/create", TopicController, :create
    get "/topics/edit/:id", TopicController, :edit

    post "/topics", TopicController, :store
    put "/topics/:id", TopicController, :update
    delete "/topics/:id", TopicController, :destroy

  end


  scope "/auth", DiscussWeb do
    pipe_through :browser

    get "/logout", AuthController, :logout
    get "/:provider", AuthController, :redirect
    get "/:provider/callback", AuthController, :callback

  end


  # Other scopes may use custom stacks.
  # scope "/api", DiscussWeb do
  #   pipe_through :api
  # end
end
