defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defp setDirection(:north), do: :north
  defp setDirection(:east), do: :east
  defp setDirection(:south), do: :south
  defp setDirection(:west), do: :west
  defp setDirection(_), do: :error

  defp setPosition({x, y}) when is_integer(x) and is_integer(y), do: {x, y}
  defp setPosition(_), do: :error

  defp changePosition(direction, {x, y}) do
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  defp changeDirection(currentIndex, instructionMove) do
    @directions
    |> Enum.at(currentIndex + instructionMove, :north)
  end

  defp move(direction, position, "R") do
    newDirection = changeDirection(@directions |> Enum.find_index(fn x -> x == direction end), 1)
    create(newDirection, position)
  end

  defp move(direction, position, "L") do
    changeDirection(@directions |> Enum.find_index(fn x -> x == direction end), -1)
    |> create(position)
  end

  defp move(direction, position, "A") do
    newPosition = changePosition(direction, position)
    create(direction, newPosition)
  end

  defp move(_, _, _), do: :error

  def create(), do: %{:direction => :north, :position => {0, 0}}

  def create(direction, position) do
    robot = %{:direction => setDirection(direction), :position => setPosition(position)}

    cond do
      robot[:direction] == :error ->
        {:error, "invalid direction"}

      robot[:position] == :error ->
        {:error, "invalid position"}

      true ->
        robot
    end
  end

  def simulate(:error, _) do
    {:error, "invalid instruction"}
  end

  def simulate(robot, "") do
    robot
  end

  def simulate(robot, instructions) do
    {currentAction, leastInstructions} = instructions |> String.split_at(1)
    move(direction(robot), position(robot), currentAction) |> simulate(leastInstructions)
  end

  def direction(robot) do
    robot[:direction]
  end

  def position(robot) do
    robot[:position]
  end
end
