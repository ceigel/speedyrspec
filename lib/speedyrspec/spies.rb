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
        @wd_path = Pathname.new(@working_dir)
      end

      def set_tracer
        TracePoint.new(*%i[call b_call]) do |tp|
          unless tp.path.index(@working_dir).nil?
            tp_path = Pathname.new(tp.path)
            @datamanager.add_dependency(tp_path.relative_path_from(@wd_path).to_s, @current_test)
          end
        end
      end
  end
end

