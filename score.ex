defmodule Score do

  def new(answer, guess) when answer == guess do
    %{reds: 4, whites: 0}
  end

  def new(answer, guess)  do
    guess_check(answer, guess)
  end

  defp no_of_reds(answer, guess) do
      answer
      |> Enum.zip(guess)
      |> Enum.filter(fn {x,y} -> x==y end)
      |> Enum.count()
  end

  defp no_of_whites(answer, guess) do
    misses = 
    guess 
    |> Kernel.--(answer)
    |> length()

    length(answer) - misses - no_of_reds(answer, guess)
  end

  defp guess_check(answer, guess) do
    reds = no_of_reds(answer, guess)
    whites = no_of_whites(answer, guess)
    %{reds: reds, whites:  whites }
  end
end


