require_relative 'speedytest/rake_tasks'
require_relative 'speedytest/resolver'

module SpeedyTest
  class << self
    attr_accessor :trace_file
    def configure
      yield self
    end
  end
end

SpeedyTest.configure do |config|
  config.trace_file = 'speedy_traces.json'
end
