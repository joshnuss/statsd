defmodule StatsD.Server do
  use GenServer

  def start_link(host, port) do
    GenServer.start_link(__MODULE__, %{
      host: host,
      port: port
    })
  end

  def init(%{port: port}) do
    :gen_udp.open(port, [:binary, active: true])
  end

  def handle_info({:udp, socket, _address, _port, packet}, socket) do
    StatsD.record(packet)

    {:noreply, socket}
  end

  def terminate(_shutdown, socket) do
    :gen_udp.close(socket)
  end
end
