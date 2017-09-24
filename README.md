StatsD
-------

A fault tolerant and concurrent metric tracker.

It has three major components:

- `collector` receives UDP packets and buffers them in memory
- `aggregator` flushes the buffer periodically and computes aggregate measurements
- `storage` persists the measurements to a backend database

## Features

### Multiple metrics

Supports all StatsD metrics: counters, guages, timers & sets.

### Streaming

Scalar data is streamed into the system via UDP packets.
Aggregate data is streamed out via a WebSocket.

### Fault tolerant

The measuring, aggregation and storage engines are self-healing. If an unexpected error occurrs, they will stay up.

### Concurrent

Takes advantage of all your cores. Can receive packets from multiple sources at the same time.

### Distributed

Can be configured to distribute the collection, aggregation and storage systems over multiple nodes.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `statsd` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:statsd, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/statsd](https://hexdocs.pm/statsd).

# Usage

In a single node environment:

```shell
# single port
statsd localhost:2000

# multiple ports
statsd localhost:2000 localhost:2001
```

In a multi-node environment:

```shell
# Boot 2 collectors, and one storage+aggregator on cluster "universe"
ssh mars "statsd 2000 --collector --cluster=universe" &
ssh mercury "statsd 2000 --collector --cluster=universe" &
ssh venus "statsd --storage --aggregator --cluster=universe" &

# Send metrics over UDP

## Set speed guage to 10000 light years
echo "spaceship.speed:10000|g" | netcat -u mars 2000

## Increment speed guage by 200
echo "spaceship.speed:+200|g" | netcat -u mercury 2000
```
