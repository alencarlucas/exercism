defmodule RomanNumerals do
  def times(_, 0), do: ""
  def times(letter, count), do: times(letter, count - 1) <> letter

  def convert(_, _, _, 0), do: ""
  def convert(one_sign, _, _, 1), do: String.duplicate(one_sign, 1)
  def convert(one_sign, _, _, 2), do: String.duplicate(one_sign, 2)
  def convert(one_sign, _, _, 3), do: String.duplicate(one_sign, 3)
  def convert(one_sign, five_sign, _, 4), do: one_sign <> five_sign
  def convert(_, five_sign, _, 5), do: five_sign
  def convert(one_sign, five_sign, _, 6), do: five_sign <> String.duplicate(one_sign, 1)
  def convert(one_sign, five_sign, _, 7), do: five_sign <> String.duplicate(one_sign, 2)
  def convert(one_sign, five_sign, _, 8), do: five_sign <> String.duplicate(one_sign, 3)
  def convert(one_sign, _, ten_sign, 9), do: one_sign <> ten_sign

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    times("M", div(number, 1000)) <>
      convert("C", "D", "M", rem(div(number, 100), 10)) <>
      convert("X", "L", "C", rem(div(number, 10), 10)) <>
      convert("I", "V", "X", rem(number, 10))
  end
end
