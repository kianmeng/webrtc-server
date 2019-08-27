defmodule Example.Peer do
  use Membrane.WebRTC.Server.Peer
  require Logger

  @impl true
  def authenticate(request, options) do
    room = :cowboy_req.binding(:room, request)
    state = %{username: "user_#{Integer.to_string(:rand.uniform(1_000_000))}", options: options}
    {:ok, %{room: room, state: state}}
  end

  @impl true
  def on_websocket_init(context, state) do
    encoded =
      %{"event" => :authenticated, "data" => %{"peer_id" => context.peer_id}}
      |> Jason.encode!()

    Logger.info("Hello there, I'm #{state.username}")
    Logger.info("These are my options: #{inspect(state.options)}")
    {:reply, {:text, encoded}, state}
  end

  @impl true
  def on_message(message, context, state) do
    Logger.info(
      "Sending message to peer #{Map.get(message, "to")} from #{context.peer_id} in room #{
        context.room
      }"
    )

    {:ok, message, state}
  end
end
