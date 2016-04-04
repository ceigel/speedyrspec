require_relative 'lib/speedytest/version'

Gem::Specification.new do |s|
  s.name        = 'speedytest'
  s.version     = SpeedyTest::VERSION
  s.date        = '2016-01-28'
  s.summary     = "SpeedyTest"
  s.description = "A gem for computing which rspec tests to run for a change"
  s.authors     = ["Cristian Eigel"]
  s.email       = 'eigelc@gmail.com'
  s.files       =  Dir['{lib,spec}/**/*.rb'] + ['README.md', 'Rakefile']
  s.test_files  = Dir['spec/**/*.rb']

  s.require_paths = ['lib']
  s.license       = 'MIT'

  s.add_runtime_dependency 'rspec', '>= 3.0'
  s.add_development_dependency 'pry-byebug', '~> 3.9'
end
