defmodule StatsDTest do
  use ExUnit.Case
  doctest StatsD

  test "record" do
    Process.register(self(), :buffer)

    StatsD.record("a stat")

    assert_receive {:record, "a stat"}
  end
end
