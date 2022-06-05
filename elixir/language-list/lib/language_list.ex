defmodule LanguageList do
  @spec new :: []
  def new() do
    []
  end

  @spec add(any, any) :: list
  def add([], language), do: [language]
  def add(list, language) do
    [language | list]
  end

  @spec remove(list) :: any
  def remove([_ | tail]) do
    tail
  end

  @spec first(list) :: any
  def first([hd | _]) do
    hd
  end

  @spec count(list) :: non_neg_integer
  def count(list) do
    length(list)
  end

  @spec functional_list?(list) :: boolean
  def functional_list?(["Elixir" | _]), do: true
  def functional_list?([]), do: false
  def functional_list?([_ | tl]), do: functional_list?(tl)
end
