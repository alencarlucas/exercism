defmodule ListOps do
  defp count([], total_length), do: total_length
  defp count([_ | l], partial_length), do: count(l, partial_length + 1)

  defp reverse([], reversed_list), do: reversed_list
  defp reverse([head | tail], []), do: reverse(tail, [head])
  defp reverse([head | tail], partial_reversed_list), do: reverse(tail,  append([head], partial_reversed_list))

  defp map([], _, partial_list), do: partial_list
  defp map([head | tail], f, partial_list), do: map(tail, f, append(partial_list, [f.(head)]))

  defp filter([], _, partial_list), do: partial_list
  defp filter([head | tail], f, partial_list), do: filter(tail, f, append(partial_list, evaluate_filter_result(f.(head), head)))
  defp evaluate_filter_result(false, _), do: []
  defp evaluate_filter_result(nil, _), do: []
  defp evaluate_filter_result(_, element), do: [element]

  defp foldl([], acc, _, _), do: acc
  defp foldl([head | tail], acc, f, index), do: foldl(tail, f.(head, acc), f, index + 1)

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    map(l, f, [])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    filter(l, f, [])
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f) do
    foldl(l, acc, f, 0)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    foldl(reverse(l), acc, f, 0)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([head | tail], b) do
    [head | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    foldl(ll, [], &(append(&2, &1)))
  end
end
