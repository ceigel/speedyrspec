require_relative 'speedyrspec/rake_tasks'
require_relative 'speedyrspec/resolver'

module SpeedyRspec
  class << self
    attr_accessor :trace_file
    attr_accessor :manager_type
    def configure
      yield self
    end
  end
end

SpeedyRspec.configure do |config|
  config.trace_file ||= 'speedy_traces.json'
  config.trace_type = :json
end
