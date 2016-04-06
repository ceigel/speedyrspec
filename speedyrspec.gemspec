require_relative 'lib/speedyrspec/version'

Gem::Specification.new do |s|
  s.name        = 'speedyrspec'
  s.version     = SpeedyRspec::VERSION
  s.date        = '2016-01-28'
  s.summary     = 'Compute the minimum set of tests exercising certain files'
  s.description = 'Compute the dependency list in a certain project and use this information for computing the minimum list of tests to run for a change.'
  s.authors     = ["Cristian Eigel"]
  s.email       = 'eigelc@gmail.com'
  s.files       =  Dir['{lib,spec}/**/*.rb'] + ['README.md', 'Rakefile']
  s.test_files  = Dir['spec/**/*.rb']

  s.require_paths = ['lib']
  s.license       = 'MIT'

  s.add_runtime_dependency 'rspec', '>= 3.0'
  s.add_runtime_dependency 'aws-sdk', '~> 2'

  s.add_development_dependency 'pry-byebug', '~> 3.3'
end
