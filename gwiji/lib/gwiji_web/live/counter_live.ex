defmodule GwijiWeb.CounterLive do
  use GwijiWeb, :live_view
  alias Gwiji.Game.Board

  # constructor
  def mount(_params, _session, socket) do
    {:ok, socket |> set_board() |> set_status()}
  end

  # converter
  def render(assigns) do
    ~L"""
    <h1>
      Welcome to the game!
    </h1>
    <pre>
      Your status: <%= @status.status %>
    </pre>
    <button phx-click="guess">Guess</button>
    """
  end

  # reducer
  def handle_event("guess", _metadata, socket) do
    new_board = Board.guess(socket.assigns.board, guess)
    {:noreply, guess(socket)}
  end

  defp guess(socket) do
    assign(socket, count: socket.assigns.count + 1)
  end

  defp set_board(socket, board \\ Board.new()) do
    assign(socket, board: board)
  end

  defp set_status(socket) do
    assign(socket, status: status(socket))
  end

  defp status(socket) do
    Board.check(socket.assigns.board)
  end
end
