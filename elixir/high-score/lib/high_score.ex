defmodule HighScore do
  @default_initial_score 0
  @spec new :: %{}
  def new(), do: %{}

  @spec add_player(map, any, any) :: map
  def add_player(scores, name, score \\ @default_initial_score), do: Map.put(scores, name, score)

  @spec remove_player(map, any) :: map
  def remove_player(scores, name) do
    { _, new_scores } = Map.pop(scores, name)
    new_scores
  end

  @spec reset_score(map, any) :: map
  def reset_score(scores, name), do: add_player(scores, name, @default_initial_score)

  @spec update_score(map, any, any) :: map
  def update_score(scores, name, score), do: Map.update(scores, name, score, fn current_score -> current_score + score end)

  @spec get_players(map) :: list
  def get_players(scores), do: Map.keys(scores)
end
