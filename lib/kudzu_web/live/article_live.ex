defmodule KudzuWeb.ArticleLive do
  use KudzuWeb, :live_view
  alias KudzuWeb.Credentials

  def render(assigns) do
    KudzuWeb.ArticleView.render("live.html", assigns)
  end

  def mount(%{"article_id" => article_id}, session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Kudzu.PubSub, "article-#{article_id}")
    end

    article      = Kudzu.Articles.get_article!(article_id)
    current_user = Credentials.get_user(socket, session)
    socket       = assign(socket, article: article, current_user: current_user, new_tag_text: nil, search_suggestions: nil)

    { :ok, socket }
  end

  def mount(_params, %{"article_id" => article_id, "current_user" => user} = session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Kudzu.PubSub, "article-#{article_id}")
    end

    article      = Kudzu.Articles.get_article!(article_id)
    current_user = Credentials.get_user(socket, session)
    socket       = assign(socket, article: article, current_user: current_user, new_tag_text: nil, search_suggestions: nil)

    { :ok, socket }
  end

  def handle_event("toggle_article_tag", %{"id" => article_id, "tag" => tag_text} = session, socket) do
    try do
      current_user    = socket.assigns.current_user
      tag             = Kudzu.Tags.find_or_create_tag(tag_text)
      article         = socket.assigns.article || Kudzu.Articles.get_article!(article_id)
      { :ok, action } = Kudzu.UserArticleTags.toggle_user_article_tag(current_user, article, tag)

      new_socket = socket
                   |> put_flash(:success, "The tag has been #{action}!")
                   |> assign(article: Kudzu.Articles.get_article!(article_id))

      { :noreply, new_socket }
    rescue
      e in KeyError -> { :noreply, socket }
    end
  end

  def handle_event("suggest_tags", session, socket) do
    tag_text = session["new_article_tag"]["tag_text"] || ""

    new_socket = socket
                 |> assign(search_suggestions: Kudzu.Tags.search_tags(tag_text))

    { :noreply, new_socket }
  end

  def handle_event("add_tag", session, socket) do
    tag_text     = session["new_article_tag"]["tag_text"]
    article_id   = session["new_article_tag"]["article_id"]
    current_user = socket.assigns.current_user

    if is_nil(tag_text) || is_nil(article_id) || is_nil(current_user) do
      { :noreply, socket }
    else
      tag     = Kudzu.Tags.find_or_create_tag(tag_text)
      article = Kudzu.Articles.get_article!(article_id)

      Kudzu.UserArticleTags.create_user_article_tag(%{
        article: article,
        tag:     tag,
        user:    current_user
      })
      |> case do
        { :ok, _uat } ->
          article    = Kudzu.Articles.get_article!(article_id)
          new_socket = socket
                       |> put_flash(:success, "Article tagged!")
                       |> assign(article: article)
                       |> assign(search_suggestions: nil)
                       |> assign(new_tag_text: nil)

          { :noreply, new_socket }

        { :error, changeset } ->
          if !is_nil(changeset.errors[:tag_id]) do
            case changeset.errors[:tag_id] do
              { "has already been taken", _foo } ->
                # TODO: why doesn't this clear the text field?
                new_socket = socket
                             |> assign(new_tag_text: nil)
                             |> assign(search_suggestions: nil)
                { :noreply, new_socket }

              { _error, _details } -> 
                { :noreply, socket }
            end
            
          else
            { :noreply, socket }
          end

        { _, _ } ->
          { :noreply, socket }
      end
    end
  end

  def handle_info(%Phoenix.Socket.Broadcast{event: event, topic: topic, payload: payload}, socket) do
    article = socket.assigns.article

    { :noreply, assign(socket, article: Kudzu.Articles.get_article!(article.id)) }
  end

  def handle_event(action, key, socket) do
    { :noreply, socket }
  end
end
