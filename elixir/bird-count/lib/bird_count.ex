defmodule BirdCount do
  @too_many_birds 5
  @spec today(list) :: integer | nil
  def today([]), do: nil
  def today([hd | _tl]), do: hd

  @spec increment_day_count(list) :: nonempty_list
  def increment_day_count([]), do: [1]
  def increment_day_count([hd | tl]), do: [hd + 1 | tl]

  @spec has_day_without_birds?(list) :: boolean
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _tl]), do: true
  def has_day_without_birds?([_hd | tl]), do: has_day_without_birds?(tl)

  defp total([], acc), do: acc
  defp total([hd | tl], acc), do: total(tl, acc + hd)
  @spec total([number]) :: number
  def total(list), do: total(list, 0)

  defp busy_days([], acc), do: acc
  defp busy_days([hd | tl], acc) when hd >= @too_many_birds, do: busy_days(tl, acc + 1)
  defp busy_days([_ | tl], acc), do: busy_days(tl, acc)
  @spec busy_days(list) :: non_neg_integer
  def busy_days(list), do: busy_days(list, 0)
end
