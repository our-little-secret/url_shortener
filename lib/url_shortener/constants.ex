defmodule UrlShortener.Constants do
  @moduledoc """
  A place to gather constants used across codebase.
  """

  def base62_character_set do
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    |> String.graphemes()
  end
end
