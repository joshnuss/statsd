# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :statsd, endpoints: [
  {"localhost", 2000},
  {"localhost", 2001},
  {"localhost", 2002}
]
