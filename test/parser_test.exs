defmodule ParserTest do
  use ExUnit.Case
  alias StatsD.{Parser, Stat}

  test "counters" do
    assert %Stat{type: :counter, bucket: "bucket", value: 1} == Parser.parse("bucket:1|c")
    assert %Stat{type: :counter, bucket: "bucket", value: 99} == Parser.parse("bucket:99|c")
  end

  test "guages" do
    assert %Stat{type: :guage, bucket: "bucket", value: 1} == Parser.parse("bucket:1|g")
    assert %Stat{type: :guage, bucket: "bucket", value: 99} == Parser.parse("bucket:99|g")
  end

  test "sets" do
    assert %Stat{type: :set, bucket: "bucket", value: 1} == Parser.parse("bucket:1|s")
    assert %Stat{type: :set, bucket: "bucket", value: 99} == Parser.parse("bucket:99|s")
  end

  test "timings" do
    assert %Stat{type: :timing, bucket: "bucket", value: 1} == Parser.parse("bucket:1|ms")
    assert %Stat{type: :timing, bucket: "bucket", value: 99} == Parser.parse("bucket:99|ms")
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
