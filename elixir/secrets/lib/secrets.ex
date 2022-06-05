defmodule Secrets do
  use Bitwise
  def secret_add(secret) do
    &(&1 + secret)
  end

  def secret_subtract(secret) do
    &(&1 - secret)
  end

  def secret_multiply(secret) do
    &(&1 * secret)
  end

  def secret_divide(secret) do
    &((&1 / secret) |> floor)
  end

  def secret_and(secret) do
    &(&1 &&& secret)
  end

  @spec secret_xor(any) :: (any -> 0 | 1)
  def secret_xor(secret) do
    &(bxor(&1, secret))
  end

  def secret_combine(secret_function1, secret_function2) do
    &(secret_function2.(secret_function1.(&1)))
  end
end
