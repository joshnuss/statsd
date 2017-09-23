defmodule StatsD.Buffer do
  use GenServer

  @name :buffer

  def start_link,
    do: GenServer.start_link(__MODULE__, [], name: @name)

  def handle_cast({:record, stat}, stats),
    do: {:noreply, [stat|stats]}

  def handle_call(:clear, _from, stats),
    do: {:reply, stats, []}

  def record(stat),
    do: GenServer.cast(@name, {:record, stat})

  def clear,
    do: GenServer.call(@name, :clear)
end
