defmodule LogLevel do
  @spec to_label(any, any) :: :debug | :error | :fatal | :info | :trace | :unknown | :warning
  def to_label(level, legacy?) do
    cond do
      level === 0 and legacy? === false -> :trace
      level === 1 -> :debug
      level === 2 -> :info
      level === 3 -> :warning
      level === 4 -> :error
      level === 5 and legacy? === false -> :fatal
      true -> :unknown
    end
  end

  defp alert_recipient_by_label(label, legacy) do
    cond do
      label === :error -> :ops
      label === :fatal -> :ops
      label === :unknown and legacy === true -> :dev1
      label === :unknown and legacy === false -> :dev2
      true -> nil
    end
  end

  @spec alert_recipient(any, any) :: :dev1 | :dev2 | nil | :ops
  def alert_recipient(level, legacy?) do
    alert_recipient_by_label(to_label(level, legacy?), legacy?)
  end
end
