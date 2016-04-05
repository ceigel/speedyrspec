require_relative 'speedyrspec/rake_tasks'
require_relative 'speedyrspec/resolver'
require_relative 'speedyrspec/dependency_manager'

module SpeedyRspec
  class << self
    attr_accessor :trace_file
    attr_accessor :trace_type
    def configure
      yield self
    end
  end
end

SpeedyRspec.configure do |config|
  config.trace_file ||= 'speedy_traces.json'
  config.trace_type = :json
end
