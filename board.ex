defmodule MindGame.Board do
  defstruct [:answer, :guesses]

  def new(answer) do
    %__MODULE__{answer: answer, guesses: []}
  end

  def guess(board, guess) do
    %{ board | guesses: [guess|board.guesses]}
  end

  def check(board, max_rows) do
    %{rows: Enum.map(board.guesses, fn guess -> %{guess: guess, score: score(guess, board.answer)} end)}
    |> put_status(max_rows)
  
  end

  defp put_status(%{rows: [row | _]} = result, max_rows) do
   status =  cond do
     Enum.count(result.rows) < max_rows and has_white_or_none_keys?(row.score) ->
        :playing

      Enum.count(result.rows) <= max_rows and !has_white_or_none_keys?(row.score) ->
        :won 

      true ->
      :lost

     end
      Map.merge(result, %{status: status})
  end

  defp has_white_or_none_keys?(score) do
    Map.has_key?(score, :white) or Map.has_key?(score, :none)
  end



defp score(guess, ans) do
 wrong_answers =  guess -- ans
 Enum.zip(ans, guess) |> Enum.frequencies_by(fn {x, y} ->  
 cond do
   x == y -> :red
   y in wrong_answers -> :none
  true -> :white
     
 end
 
 end)
end


end
