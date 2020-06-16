defmodule KudzuWeb.Router do
  use KudzuWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KudzuWeb do
    pipe_through :browser

    get "/", ArticleController, :index

    resources "/articles", ArticleController, only: [:index, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", KudzuWeb do
  #   pipe_through :api
  # end
end
