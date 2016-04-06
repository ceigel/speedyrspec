module SpeedyRspec
  class << self
    attr_accessor :trace_file
    attr_accessor :trace_type
    attr_accessor :output
    def configure
      yield self
    end
  end
end

SpeedyRspec.configure do |config|
  config.trace_file ||= 'speedy_traces.json'
  config.output = {type: :file, name: config.trace_file}.merge(config.output || {})
  # config.output = {type: :s3, name: 'shore_core_traces.json', bucket: 'speedyrspec'}.merge(config.output || {})
  config.trace_type = :json
end
