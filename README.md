StatsD
-------

A fault tolerant and concurrent metric tracker.

It has three major components:

- `collector` receives UDP packets and buffers them in memory
- `aggregator` flushes the buffer periodically and computes measurements
- `storage` persists the measurements

## Features

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
# Boot 2 collectors, and one storage/aggregator on cluster "universe"
ssh mars "statsd 2000 --collector --cluster=universe" &
ssh mercury "statsd 2000 --collector --cluster=universe" &
ssh venus "statsd --storage --aggregator --cluster=universe" &

# Send metrics over UDP
echo "Customer.created:1|2ms" | netcat -u mars 2000
echo "Customer.created:2|4ms" | netcat -u mercury 2000
```
