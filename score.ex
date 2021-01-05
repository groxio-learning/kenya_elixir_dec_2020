defmodule Score do

  def new(answer, score) when answer == score do
    %{reds: 4, whites: 0}
  end

  def new(answer, score)  do
    other_orders(answer, score)
  end

  defp elements_on_the_same_position(answer, score) do
      answer
      |> Enum.zip(score)
      |> Enum.filter(fn {x,y} -> x==y end)
  end

  defp elements_remaining_in_answer(answer, score) do
    elements_the_same_position =
    answer
    |> elements_on_the_same_position(score)
    |> Enum.map(fn {_x,y}-> y end)

    answer -- elements_the_same_position
  end

  defp number_of_white_elements(answer, score) do
    answer
    |> elements_remaining_in_answer(score)
    |> Enum.filter(fn el -> Enum.member?(score, el)end)
    |> Enum.count()
  end

  defp other_orders(answer, score) do
    number_of_white_values = number_of_white_elements(answer, score)
    number_of_red_values = elements_on_the_same_position(answer, score) |> Enum.count()
    %{reds: number_of_red_values, whites:  number_of_white_values  }
  end
end


