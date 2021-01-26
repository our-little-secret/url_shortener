defmodule UrlShortenerWeb.PageControllerTest do
  alias UrlShortener.Encoder
  use UrlShortenerWeb.ConnCase, async: true

  describe "new" do
    test "returns the home page", %{conn: conn} do
      conn = get(conn, "/")
      assert html_response(conn, 200) =~ "Web's Best URL Shortener"
    end
  end

  describe "create_shortened_url" do
    test "given valid url returns the shortened URL page", %{conn: conn} do
      conn = post(conn, "/", %{"url_to_shorten" => "http://www.example.com"})
      assert html_response(conn, 200) =~ "shortened-url-page"
    end

    @moduletag capture_log: true
    test "given invalid url returns error", %{conn: conn} do
      conn = post(conn, "/", %{"url_to_shorten" => "https://www.oiuwertkljhsadfoiul.com/asdflkjoijasdf"})

      assert html_response(conn, 200) =~ "x-error-page"
    end
  end

  describe "handle_redirect" do
    test "redirects to persisted page given a valid slug", %{conn: conn} do
      {:ok, result} = UrlShortener.ShortenedUrls.create_shortened_url(%{original_url: "https://www.example.com"})
      {:ok, slug} = Encoder.int_to_base62(result.id)
      conn = get(conn, "/#{slug}")

      assert redirected_to(conn) == "https://www.example.com"
    end

    @moduletag capture_log: true
    test "returns error page when slug is invalid", %{conn: conn} do
      conn = get(conn, "/bse3")

      assert html_response(conn, 200) =~ "x-error-page"
    end
  end
end
