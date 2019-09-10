defmodule Membrane.WebRTC.Server.Peer.State do
  @moduledoc false
  alias Membrane.WebRTC.Server.Peer.AuthData

  @enforce_keys [:module, :auth_data, :room, :peer_id, :internal_state]
  defstruct @enforce_keys

  @type t :: %__MODULE__{
          room: String.t(),
          peer_id: String.t(),
          module: module(),
          auth_data: AuthData.t() | :already_authorised,
          internal_state: Membrane.WebRTC.Server.Peer.internal_state()
        }
end
