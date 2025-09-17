defmodule Conn.SocketAddr do
    defstruct ip: {127, 0, 0, 1}, port: 40000
end

defmodule Conn do
  defstruct src: %Conn.SocketAddr{}, dst: %Conn.SocketAddr{}
end
