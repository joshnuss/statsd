defmodule StatsD.Buffer do
  use GenServer

  @name :buffer

  def start_link,
    do: GenServer.start_link(__MODULE__, [], name: @name)

  def handle_cast({:record, packet}, packets),
    do: {:noreply, [packet|packets]}

  def handle_call(:clear, _from, packets),
    do: {:reply, packets, []}

  def record(packet),
    do: GenServer.cast(@name, {:record, packet})

  def clear,
    do: GenServer.call(@name, :clear)
end
