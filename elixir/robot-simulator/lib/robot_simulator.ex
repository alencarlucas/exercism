defmodule RobotSimulator do
  alias RobotSimulator, as: Robot

  defstruct direction: :north,
            position: {0, 0}

  defguard is_valid_position(x, y) when is_integer(x) and is_integer(y)

  defp set_direction(:north), do: :north
  defp set_direction(:east), do: :east
  defp set_direction(:south), do: :south
  defp set_direction(:west), do: :west
  defp set_direction(_), do: :error

  defp set_position({x, y}) when is_valid_position(x, y), do: {x, y}
  defp set_position(_), do: :error

  defp change_position(%Robot{direction: d, position: {x, y}}) do
    case d do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  def change_direction(%Robot{direction: :north}, "R"), do: :east
  def change_direction(%Robot{direction: :north}, "L"), do: :west
  def change_direction(%Robot{direction: :east}, "R"), do: :south
  def change_direction(%Robot{direction: :east}, "L"), do: :north
  def change_direction(%Robot{direction: :south}, "R"), do: :west
  def change_direction(%Robot{direction: :south}, "L"), do: :east
  def change_direction(%Robot{direction: :west}, "R"), do: :north
  def change_direction(%Robot{direction: :west}, "L"), do: :south

  defp move(robot, "R"), do: %{robot | direction: change_direction(robot, "R")}
  defp move(robot, "L"), do: %{robot | direction: change_direction(robot, "L")}
  defp move(robot, "A"), do: %{robot | position: change_position(robot)}
  defp move(_, _), do: :error

  def create(), do: %Robot{}

  def create(direction, position) do
    robot = %Robot{direction: set_direction(direction), position: set_position(position)}

    cond do
      robot.direction == :error ->
        {:error, "invalid direction"}

      robot.position == :error ->
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
    {current_instruction, remaining_instructions} = instructions |> String.split_at(1)

    robot
    |> move(current_instruction)
    |> simulate(remaining_instructions)
  end

  def direction(%Robot{direction: d, position: _}) do
    d
  end

  def position(%Robot{direction: _, position: {x, y}}) do
    {x, y}
  end
end
