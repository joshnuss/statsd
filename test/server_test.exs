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

    :gen_udp.send(socket, host, port, "speed:899|g")

    assert_receive {:"$gen_cast", {:record, %StatsD.Stat{}}}
  end
end
