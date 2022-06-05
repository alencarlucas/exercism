defmodule HighSchoolSweetheart do
  @spec first_letter(binary) :: nil | binary
  def first_letter(name) do
    name
    |> String.trim
    |> String.at(0)
  end

  @spec initial(binary) :: nonempty_binary
  def initial(name) do
    name
    |> first_letter
    |> String.upcase
    |> then(&("#{&1}."))
  end

  @spec initials(binary) :: binary
  def initials(full_name) do
    String.split(full_name, " ")
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  @spec pair(binary, binary) :: <<_::64, _::_*8>>
  def pair(full_name1, full_name2) do
    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{ initials(full_name1) }  +  #{ initials(full_name2) }     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
    end
end
