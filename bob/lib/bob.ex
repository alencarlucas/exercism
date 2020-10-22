defmodule Bob do
  @input_types [
    {~r/((^[[:cntrl:][:blank:]]+$)|(^$))/, :silence},
    {~r/^[[:upper:]][[:upper:] \d\W]+\?$/u, :yell_question},
    {~r/(^.*?)((\?$)|(\?[[:blank:]]+))$/u, :question},
    {~r/^[\d\W]+$/, :unknow},
    {~r/^[[:upper:] \d\W]+$/u, :yell},
  ]

  defp reply(:question), do: "Sure."
  defp reply(:yell), do: "Whoa, chill out!"
  defp reply(:yell_question), do: "Calm down, I know what I'm doing!"
  defp reply(:silence), do: "Fine. Be that way!"
  defp reply(_), do: "Whatever."

  def evaluate_input(input, {regex, _}) do
    String.match?(input, regex)
  end

  def get_input_type(input) do
    {_, input_type} = Enum.find(@input_types, {nil, nil}, &evaluate_input(input, &1))
    input_type
  end

  def hey(input) do
    input
    |> get_input_type()
    |> reply()
  end
end
