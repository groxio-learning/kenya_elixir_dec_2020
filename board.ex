defmodule Board do
  defstruct [:answer, :guesses]
  def new(answer) do
    %__MODULE__{guesses: [], answer: answer}
  end
  def new do
    random_answer() |>   new()
  end
  def check(%__MODULE{} = board, guess) do
    %{board | guesses: [guess | board.guesses]}
  end
  defp random_answer do
    1..8 |> Enum.shuffle() |> Enum.take(4)
  end
end