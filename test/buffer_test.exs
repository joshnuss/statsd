defmodule BufferTest do
  use ExUnit.Case
  alias StatsD.Buffer

  setup do
    {:ok, buffer} = Buffer.start_link
    {:ok, %{buffer: buffer}}
  end

  test "records packets" do
    Buffer.record(:first)
    Buffer.record(:second)

    assert :sys.get_state(:buffer) == [:second, :first]
  end
end
