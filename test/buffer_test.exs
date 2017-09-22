defmodule BufferTest do
  use ExUnit.Case
  alias StatsD.Buffer

  setup do
    {:ok, buffer} = Buffer.start_link
    {:ok, %{buffer: buffer}}
  end

  test "recording" do
    Buffer.record(:first)
    Buffer.record(:second)

    assert :sys.get_state(:buffer) == [:second, :first]
  end

  test "clearing" do
    Buffer.record(:first)
    Buffer.record(:second)

    previous = Buffer.clear()

    assert previous == [:second, :first]
    assert :sys.get_state(:buffer) == []
  end
end
