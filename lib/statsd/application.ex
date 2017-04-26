defmodule StatsD.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    {host, port} = Application.get_env(:statsd, :socket)

    children = [
      worker(StatsD.Server, [host, port])
    ]

    opts = [strategy: :one_for_one, name: StatsD.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
