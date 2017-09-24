defmodule StatsD.Stat do
  defstruct type: :counter,
    bucket: nil,
    value: 0,
    rate: 1,
    operation: :replace
end
