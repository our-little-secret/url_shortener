defmodule UrlShortener.Encoder do
  @moduledoc """
  Handles encoding integers into base62
  """
  alias UrlShortener.Constants

  @character_set Constants.base62_character_set()
  @base Enum.count(@character_set)

  def int_to_base62(int, character_set_indices \\ [])

  def int_to_base62(0 = _product_after_base_division, character_set_indices) do
    character_set_indices
    |> convert_indices_to_characters
    |> flatten_to_string
  end

  def int_to_base62(int, character_set_indices) do
    next_step = get_next_step(int)
    character_set_index = get_character_set_index(int)

    int_to_base62(next_step, [character_set_index | character_set_indices])
  end

  defp get_next_step(int), do: div(int, @base)

  defp get_character_set_index(int), do: rem(int, @base)

  defp convert_indices_to_characters(remainders),
    do: Enum.map(remainders, &get_character_for_index/1)

  defp get_character_for_index(index), do: Enum.at(@character_set, index)

  defp flatten_to_string(character_list) do
    {:ok, List.to_string(character_list)}
  end
end
