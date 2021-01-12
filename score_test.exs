ExUnit.start()
Code.require_file("score.ex")

defmodule ScoreTest do
  use ExUnit.Case

  test "new/2" do
  assert Score.new([1, 2, 3, 4], [1, 2, 3, 4]) == %{reds: 4, whites: 0}
  assert Score.new([1, 2, 3, 4], [4, 3, 2, 1]) == %{reds: 0, whites: 4}
  assert Score.new([1, 2, 3, 4], [4, 3, 5, 6]) == %{reds: 0, whites: 2}
  assert Score.new([1, 2, 3, 4], [2, 3, 5, 4]) == %{reds: 1, whites: 2}
  assert Score.new([1, 2, 3, 4], [5, 6, 7, 8]) == %{reds: 0, whites: 0}
  assert Score.new([1, 2, 3, 4], [1, 2, 2, 2]) == %{reds: 2, whites: 0}
  assert Score.new([1, 2, 2, 2], [1, 2, 3, 4]) == %{reds: 2, whites: 0}
  end
end