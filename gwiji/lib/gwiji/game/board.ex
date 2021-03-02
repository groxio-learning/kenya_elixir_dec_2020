defmodule Gwiji.Game.Board do
  defstruct [:answer, :guesses]
  alias Gwiji.Game.Score

  def new(answer) do
    %__MODULE__{answer: answer, guesses: []}
  end

  def new do
    random_answer
    |> new
  end

  def validate(%{"guess" => _string} = params) do
    types = %{guess: :string}

    {%{}, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:guess])
    |> Ecto.Changeset.validate_length(:guess, is: 4)
    |> validate_guess()
  end

  defp validate_guess(changeset) do
    Ecto.Changeset.validate_change(changeset, :guess, fn :guess, guess ->
      guess 
      |> valid_guess?()
      |> guess_response()
    end)
  end

  defp valid_guess?(guess) do
    guess |> String.to_charlist() |> Enum.all?(fn codepoint -> codepoint in (?1..?8) end)
  end

  defp guess_response(true), do: []

  defp guess_response(false), do: [guess: "invalid"]

  # no repeats
  defp random_answer do
    1..8
    |> Enum.shuffle()
    |> Enum.take(4)
  end

  # allows repeats
  # defp random_answer do
  #   fn -> :random.uniform(8) end |> Stream.repeatedly |> Enum.take(4)
  # end

  def guess(board, guess) do
    %{board | guesses: [guess | board.guesses]}
  end

  def check(board, max_rows \\ 4) do
    %{rows: rows(board), status: status(board, max_rows)}
  end

  defp rows(%__MODULE__{guesses: guesses, answer: ans}) do
    Enum.map(
      guesses,
      fn guess ->
        %{guess: guess, score: score(guess, ans)}
      end
    )
  end

  defp status(%__MODULE__{answer: ans, guesses: [guess | _]}, _max_rows) when ans == guess do
    :won
  end

  defp status(%__MODULE__{guesses: guesses}, max_rows) do
    if Enum.count(guesses) < max_rows do
      :playing
    else
      :lost
    end
  end

  defp score(ans, guess) do
    Score.new(ans, guess)
  end

  defp wrong_answers(ans, guess) do
    guess -- ans
  end
end
