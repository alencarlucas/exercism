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

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create :: %{direction: :north, position: {0, 0}}
  def create(), do: %{:direction => :north, :position => {0, 0}}

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
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

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    {currentAction, leastInstructions} = instructions |> String.split_at(1)
    move(direction(robot), position(robot), currentAction) |> simulate(leastInstructions)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot[:direction]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot[:position]
  end
end
