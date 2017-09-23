defmodule ServerTest do
  use ExUnit.Case

  setup do
    Process.register(self(), :buffer)
    :ok
  end

  test "forwards UDP packet to buffer process" do
    host = 'localhost'
    port = 2000

    {:ok, _server} = StatsD.Server.start_link(host, port)
    {:ok, socket} = :gen_udp.open(0, [:binary])

    :gen_udp.send(socket, host, port, "99|c")

    assert_receive {:"$gen_cast", {:record, {:counter, 99}}}
  end
end
