module SpeedyRspec
  class DependencyManagerFactory
    class << self
      def new_dependencies
        build_manager.tap { |manager| manager.new_dependencies}
      end

      def load_dependencies
        build_manager.tap { |manager| manager.load_dependencies}
      end

      private

      def build_manager
        case SpeedyRspec.trace_type
        when :json
          JsonDependencyManager.new
        else
          fail 'Only :json trace type is allowed'
        end
      end
    end
  end

  class JsonDependencyManager
    def new_dependencies
      @data = Hash.new{|h, k| h[k] = Set.new}
    end

    def load_dependencies
      traces = File.read(SpeedyRspec.trace_file)
      @data = JSON.parse(traces)
    end

    def add_dependency(from, to)
      @data[from].add(to)
    end

    def get_dependencies(file)
      @data[file]
    end

    def finish
      File.write(SpeedyRspec.trace_file, to_json)
    end

    private

    def to_json
      JSON.pretty_generate(@data.map{|k,v| [k, Array(v)]}.to_h)
    end
  end
end
