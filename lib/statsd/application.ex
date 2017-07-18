defmodule StatsD.Application do
  @moduledoc false

  use Application
  import Supervisor.Spec, warn: false

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: StatsD.Supervisor]
    children = Application.get_env(:statsd, :socket)
               |> List.wrap
               |> Enum.map(&create_worker/1)

    Supervisor.start_link(children, opts)
  end

  defp create_worker({host, port}) do
    worker(StatsD.Server, [host, port], id: "#{host}:#{port}")
  end
end
