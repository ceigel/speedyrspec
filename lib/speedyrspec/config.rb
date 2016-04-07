module SpeedyRspec
  class << self
    attr_accessor :trace_file
    def output=(val)
      @output = val
    end

    def output
      return @output if @output
      return {type: :file, name: self.trace_file}
    end

    def configure
      yield self
    end
  end
end

SpeedyRspec.configure do |config|
  config.trace_file ||= 'speedy_traces.json'
  # config.output = {type: :s3, name: 'shore_core_traces.json', bucket: 'speedyrspec'}.merge(config.output || {})
end
