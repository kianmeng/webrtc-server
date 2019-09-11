defmodule Example.Peer do
  @moduledoc false

  use Membrane.WebRTC.Server.Peer
  require Logger

  @impl true
  def parse_auth_request(request) do
    room = :cowboy_req.binding(:room, request)

    if room == :undefined do
      {:error, :no_room_bound_in_url}
    else
      username = :cowboy_req.binding(:username, request, "")
      password = :cowboy_req.binding(:password, request, "")
      credentials = %{username: username, password: password}
      {:ok, credentials, nil, room}
    end
  end

  @impl true
  def on_init(_context, options) do
    state = %{options: options}
    {:ok, state}
  end

  @impl true
  def authenticate(auth_data, _context, state) do
    username = auth_data.credentials.username
    password = auth_data.credentials.password

    if username != "" and password != "" do
      state = state |> Map.put(:username, username)
      {:ok, state}
    else
      {:error, :empty_credentials}
    end
  end

  @impl true
  def on_send(message, context, state) do
    Logger.info(
      "Sending message to peer #{message.to} from #{context.peer_id} in room #{context.room}"
    )

    {:ok, message, state}
  end
end
