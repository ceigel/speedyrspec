module SpeedyRspec
  class Resolver
    def initialize
      @dependencies = DependencyManagerFactory.load_dependencies
    end

    def get_tests(files_to_test)
      files_to_test.flat_map do |f|
        @dependencies.get_dependencies(f)
      end.compact.uniq
    end
  end
end
