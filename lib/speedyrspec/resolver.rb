module SpeedyTest
  class Resolver
    def initialize
      raise "Trace file '#{SpeedyTest.trace_file}' doesn't exist. Have you run rake speedytest:collect?" unless File.exists?(SpeedyTest.trace_file)
      traces = File.read(SpeedyTest.trace_file)
      @dependencies = JSON.parse(traces)
    end

    def get_tests(files_to_test)
      files_to_test.flat_map do |f|
        path = File.absolute_path(f)
        @dependencies[path]
      end.compact.uniq
    end
  end
end
