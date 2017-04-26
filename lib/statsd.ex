defmodule StatsD do
  @moduledoc """
  Documentation for StatsD.
  """

  def record(packet),
    do: send(:buffer, {:record, packet})
end
