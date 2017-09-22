defmodule StatsD.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: StatsD.Supervisor]
    children = listeners() ++ buffers()

    Supervisor.start_link(children, opts)
  end

  defp listeners do
    Application.get_env(:statsd, :endpoints)
    |> List.wrap
    |> Enum.map(&listener/1)
  end

  defp buffers do
    [worker(StatsD.Buffer, [])]
  end

  defp listener({host, port}) do
    worker(StatsD.Server, [host, port], id: "#{host}:#{port}")
  end
end
