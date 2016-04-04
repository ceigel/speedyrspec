require 'speedyrspec'
require_relative 'spies'
require 'rspec'

RSpec.configure do |config|
  config.before(:suite) do
    SpeedyRspec.spy.start
  end

  config.after(:suite) do
    SpeedyRspec.spy.finish
  end

  config.before(:each) do |example|
    SpeedyRspec.spy.test_starts(example)
  end

  config.after(:each) do |example|
    SpeedyRspec.spy.test_ends(example)
  end
end
