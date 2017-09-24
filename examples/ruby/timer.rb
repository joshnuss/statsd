require_relative 'setup'

StatsD.measure('FooBar.baz') do
  sleep 1.12
end
