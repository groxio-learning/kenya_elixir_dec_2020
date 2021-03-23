defmodule GwijiWeb.CounterLive do
  use GwijiWeb, :live_view
  alias Gwiji.Game.Board

  # constructor
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> set_board()
     |> set_game()
     |> set_initial_count()}
  end

  # converter
  def render(assigns) do
    ~L"""
    <h1>
      Welcome to the game!
    </h1>
    <%= for row <- @game.rows do %>
    <%= inspect row %>
    <% end %>
    <pre>
      Your status: <%= @game.status %>
    </pre>
    <form phx-submit="guess">
    <input type="text" name="guess">
    <button type="submit">Guess</button>
    </form>
    """
  end

  # reducer
  def handle_event("guess", %{"guess" => guess} = params, socket) do
    params
    |> Board.validate()
    |> validate(socket, guess)
  end

  defp validate(changeset, socket, guess) do
    if changeset.valid? do
      {:noreply,
       update_board(socket, guess)
       |> set_game()}
    else
      {:noreply,
       update_board(socket, guess)
       |> put_flash(:error, "Wrong guess")
       |> redirect(to: Routes.live_path(socket, __MODULE__))}
    end
  end

  defp update_board(socket, guess) do
    assign(socket, board: Board.guess(socket.assigns.board, guess))
  end

  defp set_initial_count(socket) do
    assign(socket, count: 0)
  end

  # defp guess(socket) do
  #   assign(socket, count: socket.assigns.count + 1)
  # end

  defp set_board(socket, board \\ Board.new()) do
    IO.inspect(board)
    assign(socket, board: board |> Board.guess([8, 5, 1, 4]) |> Board.guess([2, 3, 5, 7]))
  end

  defp set_game(socket) do
    assign(socket, game: Board.check(socket.assigns.board))
  end
end
