require 'statsd-instrument'

StatsD.backend = StatsD::Instrument::Backends::UDPBackend.new("127.0.0.1:2000", :statsd)
