defmodule UrlShortenerWeb.PageController do
  alias UrlShortener.{Decoder, Encoder, ShortenedUrls}
  alias UrlShortenerWeb.RequestBoundary
  use UrlShortenerWeb, :controller
  require Logger

  def new(conn, _params) do
    render(conn, "index.html", csrf_token: get_csrf_token())
  end

  def create_shortened_url(conn, %{"url_to_shorten" => url_to_shorten} = _params) do
    with :ok <- RequestBoundary.validate_url(url_to_shorten),
         {:ok, %{id: id}} <- ShortenedUrls.create_shortened_url(%{original_url: url_to_shorten}),
         {:ok, encoded_id} <- Encoder.int_to_base62(id) do
      render(conn, "shortened_url.html", encoded_slug: encoded_id)
    else
      {:error, error} ->
        render_error(conn, error)
    end
  end

  def handle_redirect(conn, %{"slug" => slug} = _params) do
    with :ok <- RequestBoundary.validate_slug(slug),
         {:ok, maybe_valid_id} <- Decoder.base62_to_int(slug),
         {:ok, long_url} <- ShortenedUrls.get_long_url_by_id(maybe_valid_id) do
      redirect(conn, external: long_url)
    else
      {:error, error} ->
        render_error(conn, error)
    end
  end

  defp render_error(conn, error) do
    Logger.warn(error)
    render(conn, "error.html")
  end
end
