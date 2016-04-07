require 'json'
require 'open-uri'
require_relative 'json_writers'

module SpeedyRspec
  class DependencyManagerFactory
    class << self
      def new_dependencies
        build_manager(build_traces_writer).tap { |manager| manager.new_dependencies}
      end

      def load_dependencies
        build_manager(build_traces_writer).tap { |manager| manager.load_dependencies}
      end

      private

      def build_traces_writer
        case SpeedyRspec.output[:type]
        when :file
          JsonFileWriter.new
        when :s3
          JsonS3Writer.new
        else
          JsonFileWriter.new
        end
      end

      def build_manager(file_writer)
        JsonDependencyManager.new(file_writer)
      end
    end
  end

  class JsonDependencyManager
    def initialize(data_writer)
      @writer = data_writer
    end
    def new_dependencies
      @data = Hash.new{|h, k| h[k] = Set.new}
    end

    def load_dependencies
      open(SpeedyRspec.trace_file) do |f|
        @data = JSON.parse(f.read)
      end
    end

    def add_dependency(from, to)
      @data[from].add(to)
    end

    def get_dependencies(from)
      Array(@data[from]) || []
    end

    def finish
      @writer.write(to_json)
    end

    private

    def to_json
      JSON.pretty_generate(@data.map{|k,v| [k, Array(v)]}.to_h)
    end
  end
end
