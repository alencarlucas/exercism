defmodule FreelancerItinerary do
  defstruct [
    business_hours_per_day: 8.0,
    business_days_per_month: 22
  ]
end

defmodule FreelancerRates do
  @freelancer_itinerary %FreelancerItinerary{}

  @spec daily_rate(number) :: float
  def daily_rate(hourly_rate) do
    hourly_rate * @freelancer_itinerary.business_hours_per_day
  end

  @spec apply_discount(number, number) :: float
  def apply_discount(before_discount, discount) do
    before_discount * (1 - (discount / 100))
  end

  @spec monthly_rate(number, number) :: integer
  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> (&(&1 * @freelancer_itinerary.business_days_per_month)).()
    |> apply_discount(discount)
    |> ceil
  end

  @spec days_in_budget(any, number, number) :: float
  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> apply_discount(discount)
    |> (&(budget / &1)).()
    |> Float.floor(1)
  end
end
