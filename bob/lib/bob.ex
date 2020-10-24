defmodule Bob do
  defp reply([:question, :yell]), do: "Calm down, I know what I'm doing!"
  defp reply([:question]), do: "Sure."
  defp reply([:yell]), do: "Whoa, chill out!"
  defp reply([:silence]), do: "Fine. Be that way!"
  defp reply([]), do: "Whatever."

  defp is_yell?(input) do
    String.upcase(input) == input and String.match?(input, ~r/[[:alpha:]]/)
  end

  defp is_question?(input) do
    String.last(input) == "?"
  end

  defp is_silence?(input) do
    input == ""
  end

  defp get_input_type(input) do
    cond do
      input |> is_silence? -> [:silence]
      input |> is_question? and input |> is_yell? -> [:question, :yell]
      input |> is_question? -> [:question]
      input |> is_yell? -> [:yell]
      true -> []
    end
  end

  def hey(input) do
    input
    |> String.trim()
    |> get_input_type()
    |> reply()
  end
end
