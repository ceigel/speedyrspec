require_relative 'speedyrspec/rake_tasks'
require_relative 'speedyrspec/resolver'

module SpeedyRspec
  class << self
    attr_accessor :trace_file
    def configure
      yield self
    end
  end
end

SpeedyRspec.configure do |config|
  config.trace_file = 'speedy_traces.json'
end
