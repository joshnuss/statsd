defmodule StatsD do
  @moduledoc """
  Documentation for StatsD.
  """

  defdelegate record(packet), to: StatsD.Buffer
end
