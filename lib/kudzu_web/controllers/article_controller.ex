defmodule KudzuWeb.ArticleController do
  use KudzuWeb, :controller

  def index(conn, params) do
    conn
    |> Plug.Conn.assign(:latest_articles, Kudzu.Articles.list_latest_articles(params))
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    article = Kudzu.Articles.get_article!(id)
    user    = Pow.Plug.current_user(conn)

    if is_nil(user) do
      render(conn, "show.html", article: article)
    else
      redirect(conn, to: "/articles/#{article.id}/live")
    end
  end

  def tag(conn, params) do
    user = Pow.Plug.current_user(conn)

    if is_nil(user) do
      conn
      |> put_status(:forbidden)
      |> put_view(KudzuWeb.ErrorView)
      |> render(:"403")
    else
      tag     = Kudzu.Tags.find_or_create_tag(params["tag"])
      article = Kudzu.Articles.get_article!(params["article_id"])

      { :ok, user_article_tag } = Kudzu.UserArticleTags.create_user_article_tag(%{
        article: article,
        tag:     tag,
        user:    user
      })

      msg = %{"success": true, "tag_id": tag.id, "tag_tag": tag.tag}
      json(conn, msg)
    end
  end
end
