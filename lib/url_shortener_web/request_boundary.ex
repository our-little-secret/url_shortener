defmodule UrlShortenerWeb.RequestBoundary do
  @moduledoc """
  All requests are processed through here before heading into other areas of
  system
  """
  alias UrlShortener.Constants

  @character_set Constants.base62_character_set()

  def validate_url(url) do
    with :ok <- validate_length(url),
         :ok <- validate_scheme(url),
         :ok <- validate_domain(url) do
      :ok
    else
      {:error, error} ->
        {:error, error}
    end
  end

  defp validate_length(url) do
    # 2083 is a fairly widely aggreed upon URL length limit since IE breaks
    # breaks after this
    case String.length(url) < 2084 do
      true -> :ok
      false -> {:error, "Domain is too long."}
    end
  end

  defp validate_scheme(url) do
    scheme = url |> URI.parse() |> Map.get(:scheme)
    case is_scheme_http?(scheme) do
      false ->
        {:error, "URL scheme not accepted"}
      true ->
        :ok
    end
  end

  defp is_scheme_http?(nil), do: false
  defp is_scheme_http?(scheme) do
    String.contains?("https", scheme)
  end

  defp validate_domain(url) do
    case lookup_domain(url) do
      {:ok, _} ->
        :ok

      _ ->
        {:error, "Domain submitted doesn't seem to exist."}
    end
  end

  defp lookup_domain(url) do
    case url |> URI.parse() |> Map.get(:host) do
      nil ->
        :error

      domain ->
        domain
        |> String.to_charlist()
        |> :inet.gethostbyname()
    end
  end

  def validate_slug(slug) do
    with :ok <- valid_base62_string(slug),
         :ok <- within_postgres_id_range(slug) do
      :ok
    else
      {:error, error} ->
        {:error, error}
    end
  end

  defp valid_base62_string(slug) do
    case slug
         |> String.graphemes()
         |> Enum.all?(fn character -> character in @character_set end) do
      true -> :ok
      false -> {:error, "Not valid base62 string."}
    end
  end

  # any valid base62 string over 11 characters in length represents a integer
  # larger than what postgrex allows for an ID
  defp within_postgres_id_range(slug) do
    case String.length(slug) < 12 do
      true ->
        :ok

      false ->
        {:error,
         "Valid base62 slug but exceeds postgrex ID range. Represents a mistype or system abuse."}
    end
  end
end
