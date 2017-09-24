defmodule StatsD.Stat do
  defstruct type: :counter,
    bucket: nil,
    value: 0
end
