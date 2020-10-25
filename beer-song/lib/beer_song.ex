defmodule BeerSong do
  defp get_verse(0) do
    "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  defp get_verse(1) do
    "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
  end

  defp get_verse(2) do
    "2 bottles of beer on the wall, 2 bottles of beer.\nTake one down and pass it around, 1 bottle of beer on the wall.\n"
  end

  defp get_verse(number) do
    "#{number} bottles of beer on the wall, #{number} bottles of beer.\nTake one down and pass it around, #{
      number - 1
    } bottles of beer on the wall.\n"
  end

  defp concatenate_lyrics(number, "") do
    verse(number)
  end

  defp concatenate_lyrics(number, lyrics) do
    lyrics <> "\n" <> verse(number)
  end

  def verse(number) do
    get_verse(number)
  end

  def lyrics(range) do
    Enum.reduce(range, "", &concatenate_lyrics(&1, &2))
  end

  def lyrics() do
    lyrics(99..0)
  end
end
