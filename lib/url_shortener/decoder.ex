defmodule UrlShortener.Decoder do
  @moduledoc """
  Handles decoding integers from base62 encoded strings.
  """
  alias UrlShortener.Constants

  @character_set Constants.base62_character_set()
  @base Enum.count(@character_set)

  @spec base62_to_int(String.t()) :: integer
  def base62_to_int(base62_string) do
    base62_string
    |> split_string_to_list
    |> get_base62_character_indices
    |> get_exponents_for_indices
    |> handle_reversing_encoding_math
    |> sum_values
    |> coerce_to_int
  end

  @spec split_string_to_list(String.t()) :: [String.t()]
  defp split_string_to_list(encoded_string), do: String.graphemes(encoded_string)

  @spec get_base62_character_indices([String.t()]) :: [integer()]
  defp get_base62_character_indices(base62_character_list) do
    base62_character_list
    |> Enum.map(&get_base62_character_index/1)
  end

  # returns the character set index for an encoded character
  @spec get_base62_character_index(String.t()) :: integer
  defp get_base62_character_index(encoded_character) do
    Enum.find_index(@character_set, fn character ->
      character == encoded_character
    end)
  end

  @spec get_exponents_for_indices([integer()]) :: [{integer, integer}]
  defp get_exponents_for_indices(list) do
    list
    |> Enum.reverse()
    |> Enum.with_index()
  end

  @spec handle_reversing_encoding_math([{integer, integer}]) :: [float]
  defp handle_reversing_encoding_math(indices_with_exponents) do
    indices_with_exponents
    |> Enum.map(fn {multiplier, exponent} ->
      raise_to_power(exponent) |> multiply(multiplier)
    end)
  end

  @spec raise_to_power(integer) :: float
  defp raise_to_power(exponent), do: :math.pow(@base, exponent)

  @spec multiply(float, integer) :: float
  defp multiply(multiplicand, multiplier), do: multiplicand * multiplier

  @spec sum_values([float]) :: float
  defp sum_values(values), do: Enum.sum(values)

  @spec coerce_to_int(float) :: integer
  defp coerce_to_int(float), do: {:ok, Kernel.round(float)}
end
