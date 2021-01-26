defmodule UrlShortener.DecoderTest do
  use UrlShortenerWeb.ConnCase, async: true
  alias UrlShortener.Decoder

  describe "base62_to_int" do
    test "given a base62 encoded string returns the id" do
      actual = Decoder.base62_to_int("h1b")
      expected = {:ok, 30195}

      assert actual == expected
    end
  end
end
