defmodule Lasagna do
  @expected_minutes_in_oven 40
  @minutes_to_prepare_layer 2

  @spec expected_minutes_in_oven :: number
  def expected_minutes_in_oven(), do: @expected_minutes_in_oven

  @spec remaining_minutes_in_oven(number) :: number
  def remaining_minutes_in_oven(time_spent_in_oven) do
    expected_minutes_in_oven() - time_spent_in_oven
  end

  @spec preparation_time_in_minutes(number) :: number
  def preparation_time_in_minutes(number_of_layers) do
    number_of_layers * @minutes_to_prepare_layer
  end

  @spec total_time_in_minutes(number, number) :: number
  def total_time_in_minutes(layers, time_spent_in_oven) do
    preparation_time_in_minutes(layers) + time_spent_in_oven
  end

  @spec alarm :: binary
  def alarm(), do: "Ding!"
end
