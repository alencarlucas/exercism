defmodule Username do
  defp map_char(char) do
    case char do
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      ?_ -> [?_]
      x when x >= ?a and x <= ?z -> [char]
      _ -> []
    end
  end

  @spec sanitize(charlist()) :: charlist()
  def sanitize(username) do
    Enum.reduce(username, [], fn e, acc -> acc ++ map_char(e) end)
  end
end
