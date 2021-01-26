defmodule UrlShortener.EncoderTest do
  use UrlShortenerWeb.ConnCase, async: true
  alias UrlShortener.Encoder

  describe "int_to_base62" do
    test "given an integer returns the correctly encoded string value" do
      actual = Encoder.int_to_base62(30195)
      expected = {:ok, "h1b"}

      assert actual == expected
    end
  end
end
