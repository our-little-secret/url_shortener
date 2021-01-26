defmodule UrlShortenerWeb.RequestBoundaryTest do
  use UrlShortenerWeb.ConnCase, async: true
  alias UrlShortenerWeb.RequestBoundary

  describe "validate_url" do
    test "returns ok if url is shorter than max length and valid domain" do
      actual = RequestBoundary.validate_url("https://www.google.com/webhp")
      expected = :ok

      assert actual == expected
    end

    test "returns error if url is longer than max allowed length" do
      actual = RequestBoundary.validate_url("https://www.google.com/#{generate_url_chars_of_length(2089)}")
      expected = {:error, "Domain is too long."}

      assert actual == expected
    end

    test "returns error if domain is invalid" do
      actual = RequestBoundary.validate_url("https://www.lsdfiouwrtknj.com/")
      expected = {:error, "Domain submitted doesn't seem to exist."}

      assert actual == expected
    end
  end

  describe "validate_slug" do
    test "returns ok if all characters are valid base62" do
      actual = RequestBoundary.validate_slug("aBG32")
      expected = :ok

      assert actual == expected
    end

    test "returns ok if slug represents number smaller than what postgrex allows for ID" do
      actual = RequestBoundary.validate_slug("asdf")
      expected = :ok

      assert actual == expected
    end

    test "returns error if invalid base62 string" do
      actual = RequestBoundary.validate_slug("afb*!")
      expected = {:error, "Not valid base62 string."}

      assert actual == expected
    end

    test "returns error if slug represents number larger than what postgrex allows for ID" do
      actual = RequestBoundary.validate_slug("k9viXaIfiWhi")

      expected =
        {:error,
         "Valid base62 slug but exceeds postgrex ID range. Represents a mistype or system abuse."}

      assert actual == expected
    end
  end

  defp generate_url_chars_of_length(length) do
    length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64
    |> binary_part(0, length)
  end
end
