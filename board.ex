defmodule MindGame.Board do
  defstruct [:answer, :guesses]

  def new(answer) do
    %__MODULE__{answer: answer, guesses: []}
  end

  def check(board, guess) do
    %{ board | guesses: [guess|board.guesses]}
  end

end

