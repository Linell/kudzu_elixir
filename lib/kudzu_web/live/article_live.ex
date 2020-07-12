defmodule KudzuWeb.ArticleLive do
  use Phoenix.LiveView
  alias KudzuWeb.Credentials

  require IEx

  def render(assigns) do
    KudzuWeb.ArticleView.render("live.html", assigns)
  end

  def mount(%{"article_id" => article_id}, session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 30000)

    article      = Kudzu.Articles.get_article!(article_id)
    current_user = Credentials.get_user(socket, session)
    socket       = assign(socket, article: article, current_user: current_user, new_tag_text: nil)

    { :ok, socket }
  end

  def mount(params, session, socket) do
    IEx.pry

    { :ok, socket }
  end

  def handle_info(:update, socket)  do
    IO.puts "Remember to remove me! I'm from the connected? call above!"
    { :noreply, socket }
  end

  def handle_event("add_tag", session, socket) do
    tag_text     = session["new_article_tag"]["tag_text"]
    article_id   = session["new_article_tag"]["article_id"]
    current_user = socket.assigns.current_user

    if is_nil(tag_text) || is_nil(article_id) || is_nil(current_user) do
      IEx.pry

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
                       |> assign(new_tag_text: nil)

          { :noreply, new_socket }

        { :error, changeset } ->
          if !is_nil(changeset.errors[:tag_id]) do
            case changeset.errors[:tag_id] do
              { "has already been taken", _foo } ->
                # TODO: why doesn't this clear the text field?
                new_socket = socket
                             |> assign(new_tag_text: nil)
                { :noreply, new_socket }

              { _error, _details } -> 
                { :noreply, socket }
            end
            
          else
            { :noreply, socket }
          end

        { _, _ } ->
          IEx.pry

          { :noreply, socket }
      end
    end
  end

  def handle_event(action, key, socket) do
    { :noreply, socket }
  end
end
