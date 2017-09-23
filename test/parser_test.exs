defmodule ParserTest do
  use ExUnit.Case
  alias StatsD.Parser

  test "counters" do
    assert {:counter, 1} == Parser.parse("1|c")
    assert {:counter, 99} == Parser.parse("99|c")
  end

  test "guages" do
    assert {:guage, 1} == Parser.parse("1|g")
    assert {:guage, 99} == Parser.parse("99|g")
  end

  test "sets" do
    assert {:set, 1} == Parser.parse("1|s")
    assert {:set, 99} == Parser.parse("99|s")
  end

  test "raises when invalid" do
    assert_raise Parser.Error, "Failed to parse `wha?`", fn ->
      Parser.parse("wha?")
    end
  end
end
