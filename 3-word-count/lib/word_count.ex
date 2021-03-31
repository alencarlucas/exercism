defmodule WordCount do
  defp accPhrase(map, phrase) do
    Map.update(map, phrase, 1, &(&1 + 1))
  end

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)
    |> Enum.reduce(%{}, &accPhrase(&2, &1))
  end
end
