defmodule MindGame.Board do
  alias __MODULE__
  defstruct [:answer, :guesses]

  def new(answer) do
    %__MODULE__{answer: answer, guesses: []}
  end

  def guess(board, guess) do
    %{board | guesses: [guess | board.guesses]}
  end

  def check(board, max_rows \\ 4) do
    %{rows: rows(board), status: status(board, max_rows)}
  end

  defp rows(%Board{guesses: guesses, answer: ans}) do
    Enum.map(guesses, fn guess -> %{guess: guess, score: score(guess, ans)} end)
  end

  defp status(%Board{answer: ans, guesses: [guess | _]}, _max_rows) when ans == guess do
    :won
  end

  defp status(%Board{guesses: guesses}, max_rows) do
    if Enum.count(guesses) < max_rows do
      :playing
    else
      :lost
    end
  end

  defp score(ans, guess) do
    ans
    |> Enum.zip(guess)
    |> Enum.frequencies_by(fn {x, y} ->
      cond do
        x == y -> :red
        y in wrong_answers(ans, guess) -> :none
        true -> :white
      end
    end)
  end

  defp wrong_answers(ans, guess) do
    guess -- ans
  end
end