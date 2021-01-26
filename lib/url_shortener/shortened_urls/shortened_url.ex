defmodule UrlShortener.ShortenedUrls.ShortenedUrl do
  @moduledoc """
  Represents records of shortened URLs.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "shortened_urls" do
    field(:original_url, :string)

    timestamps()
  end

  def changeset(shortened_url, attrs) do
    shortened_url
    |> cast(attrs, [:original_url])
    |> validate_required([:original_url])
  end
end
