module SpeedyRspec
  def self.spy
    @spy ||= TracingSpy.new
  end

  class TracingSpy
    def initialize
      @datamanager = DependencyManagerFactory.new_dependencies
    end

    def start
      puts 'Starting test suite with tracing enabled.'
      @tracer = set_tracer
    end

    def finish
      @datamanager.finish
    end

    def test_starts(example)
      deduce_workingdir(example) unless @working_dir
      @current_test = example.file_path
      @tracer.enable
    end

    def test_ends(example)
      @tracer.disable
    end

    private

      def deduce_workingdir(example)
        fp = example.metadata[:file_path]
        path = example.metadata[:absolute_file_path]
        @working_dir = path[0, path.index(fp[1, fp.length])]
        @working_dir_length = @working_dir.length
      end

      def set_tracer
        TracePoint.new(*%i[call b_call]) do |tp|
          unless tp.path.index(@working_dir).nil?
            @datamanager.add_dependency(tp.path, @current_test)
          end
        end
      end
  end
end

