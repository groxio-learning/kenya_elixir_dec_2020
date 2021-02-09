defmodule GwijiWeb.CounterLive do
  use GwijiWeb, :live_view
  alias Gwiji.Game.Board

  # constructor
  def mount(_params, _session, %{assigns: assigns}=socket) do
    board = Board.new()
    {:ok, assign(socket, count: 0, board: board, status: Board.check(board))}
  end
  
  # converter
  def render(assigns) do
    ~L"""
    <h1>
      Welcome to the counter!
    </h1>
    <h2>
      Your count: <%= @count %>
    </h2>
    <pre>
      Your status: <%= @status %>
    </pre>
    <button phx-click="inc">Increment</button>
    """
  end

  # reducer
  def handle_event("inc", _metadata, socket) do
    {:noreply, inc(socket)}
  end
  
  defp inc(socket) do
    assign(socket, count: socket.assigns.count + 1)
  end

end
