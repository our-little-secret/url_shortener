defmodule UrlShortener.Repo.Migrations.AddShortenedUrlsTable do
  use Ecto.Migration

  def change do
    create table(:shortened_urls) do
      add :original_url, :string
      timestamps()
    end
  end
end
