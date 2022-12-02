defmodule NameBadge do
  def print(id, name, department) do
    parsed_id = if id == nil, do: "", else: ~s([#{id}] - )
    parsed_department = if department == nil, do: " - OWNER", else: ~s( - #{String.upcase(department)})
    Enum.join([parsed_id, name, parsed_department])
  end
end
