defmodule ParserTest do
  use ExUnit.Case
  alias StatsD.{Parser, Stat}

  test "counters" do
    assert %Stat{type: :counter, bucket: "bucket", value: 1, rate: 1, operation: :replace} == Parser.parse("bucket:1|c")
    assert %Stat{type: :counter, bucket: "bucket", value: 99, rate: 1, operation: :replace} == Parser.parse("bucket:99|c")
    assert %Stat{type: :counter, bucket: "bucket", value: 99, rate: 0.1, operation: :replace} == Parser.parse("bucket:99|c|@0.1")
  end

  test "guages" do
    assert %Stat{type: :guage, bucket: "bucket", value: 1, rate: 1, operation: :replace} == Parser.parse("bucket:1|g")
    assert %Stat{type: :guage, bucket: "bucket", value: 99, rate: 1, operation: :replace} == Parser.parse("bucket:99|g")
    assert %Stat{type: :guage, bucket: "bucket", value: 1, rate: 1, operation: :increment} == Parser.parse("bucket:+1|g")
    assert %Stat{type: :guage, bucket: "bucket", value: 1, rate: 1, operation: :decrement} == Parser.parse("bucket:-1|g")
  end

  test "sets" do
    assert %Stat{type: :set, bucket: "bucket", value: 1, rate: 1, operation: :replace} == Parser.parse("bucket:1|s")
    assert %Stat{type: :set, bucket: "bucket", value: 99, rate: 1, operation: :replace} == Parser.parse("bucket:99|s")
  end

  test "timers" do
    assert %Stat{type: :timer, bucket: "bucket", value: 1, rate: 1, operation: :replace} == Parser.parse("bucket:1|ms")
    assert %Stat{type: :timer, bucket: "bucket", value: 99, rate: 1, operation: :replace} == Parser.parse("bucket:99|ms")
  end

  test "raises when invalid" do
    assert_raise Parser.Error, "Failed to parse `wha?`", fn ->
      Parser.parse("wha?")
    end
  end

  test "raises when badly formatted " do
    assert_raise Parser.Error, "Failed to parse `x:NaN|c`", fn ->
      Parser.parse("x:NaN|c")
    end

    assert_raise Parser.Error, "Failed to parse `1|c`", fn ->
      Parser.parse("1|c")
    end

    assert_raise Parser.Error, "Failed to parse `x:`", fn ->
      Parser.parse("x:")
    end
  end
end
