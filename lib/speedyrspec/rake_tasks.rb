require 'rake/tasklib'
require 'rspec/core/rake_task'

def git_modified_files
  status = open('|git status -s').readlines
  status.map(&:strip).flat_map{|s| s.split.drop(1)}.tap do |files|
    raise 'No file was modiffied in your git repository.' if files.empty?
  end
end

def set_files_to_run(t, files_to_test)
  t.pattern = 'deliberately-left-blank'
  t.rspec_opts = SpeedyRspec::Resolver.new.get_tests(files_to_test)
end

def files_from_args(args)
  (args[:files] || ARGV.drop(1) || []).tap do |files_to_test|
    raise 'Please specify which file needs to be tested' if files_to_test.empty?
  end
end

def show_files_to_run(files_to_test)
  files = SpeedyRspec::Resolver.new.get_tests(files_to_test)
  puts "Files to run: \n\t#{files.join("\n\t")}"
end

desc 'run tests and collect trace information'
RSpec::Core::RakeTask.new('speedyrspec:collect') do |t, args|
  t.rspec_opts ||= []
  specfiles = ARGV.drop(1)

  if specfiles && !specfiles.empty?
    t.rspec_opts << specfiles.join(' ')
    t.pattern = 'deliberately-left-blank'
  end

  t.rspec_opts << '--require speedyrspec/rspec_config'
end

desc 'run tests that exercise specific code'
RSpec::Core::RakeTask.new('speedyrspec:run', :files) do |t, args|
  files_to_test = files_from_args(args)
  set_files_to_run(t, files_to_test)
end


desc 'run tests that exercise modiffied git files.'
RSpec::Core::RakeTask.new('speedyrspec:run:git') do |t, args|
  files_to_test = git_modified_files
  set_files_to_run(t, files_to_test)
end

desc 'show which files will be run for given files.'
task 'speedyrspec:show' do |t, args|
  files_to_test = files_from_args(args)
  show_files_to_run(files_to_test)
end

desc 'show which files will be run for modffied git files.'
task 'speedyrspec:show:git' do |t, args|
  files_to_test = git_modified_files
  show_files_to_run(files_to_test)
end
