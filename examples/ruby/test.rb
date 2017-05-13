# gem install statsd-instrument
# bin/statsd
require 'statsd-instrument'

StatsD.backend = StatsD::Instrument::Backends::UDPBackend.new("127.0.0.1:2000", :statsd)

StatsD.measure('FooBar.baz') do
  sleep 1.12
end
