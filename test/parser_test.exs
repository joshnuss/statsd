defmodule ParserTest do
  use ExUnit.Case
  alias StatsD.Parser

  test "counters" do
    assert {:counter, 1} == Parser.parse("1|c")
    assert {:counter, 99} == Parser.parse("99|c")
  end

  test "raises when invalid" do
    assert_raise Parser.Error, "Failed to parse `wha?`", fn ->
      Parser.parse("wha?")
    end
  end
end
