defmodule StatsD.Buffer do
  use GenServer

  @name :buffer

  def start_link,
    do: GenServer.start_link(__MODULE__, [], name: @name)

  def handle_cast({:record, packet}, packets) do
    IO.puts "Recording #{inspect packet}"
    {:noreply, [packet|packets]}
  end

  def record(packet),
    do: GenServer.cast(@name, {:record, packet})
end
