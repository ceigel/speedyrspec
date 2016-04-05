module SpeedyRspec
  class Resolver
    def initialize
      raise "Trace file '#{SpeedyRspec.trace_file}' doesn't exist. Have you run rake speedyrspec:collect?" unless File.exists?(SpeedyRspec.trace_file)
      @dependencies = DependencyManagerFactory.load_dependencies
    end

    def get_tests(files_to_test)
      files_to_test.flat_map do |f|
        path = File.absolute_path(f)
        @dependencies.get_dependencies(path)
      end.compact.uniq
    end
  end
end
