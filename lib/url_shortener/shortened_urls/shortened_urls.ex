defmodule UrlShortener.ShortenedUrls do
  @moduledoc """
  ShortenedUrl context.
  """
  import Ecto.Query, warn: false
  alias UrlShortener.Repo
  alias __MODULE__.ShortenedUrl

  def get_long_url_by_id(id) do
    case Repo.get(ShortenedUrl, id) do
      nil -> {:error, "Invalid ID"}
      shortened_url -> {:ok, shortened_url.original_url}
    end
  end

  def create_shortened_url(attrs \\ %{}) do
    %ShortenedUrl{}
    |> ShortenedUrl.changeset(attrs)
    |> Repo.insert()
  end
end
