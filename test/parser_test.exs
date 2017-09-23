defmodule ParserTest do
  use ExUnit.Case
  alias StatsD.Parser

  test "parses counter" do
    assert {:counter, 1} == Parser.parse("1|c")
  end

  test "raises when invalid" do
    assert_raise Parser.Error, "invalid input `wha?`", fn ->
      Parser.parse("wha?")
    end
  end
end
