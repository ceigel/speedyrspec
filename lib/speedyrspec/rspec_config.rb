require_relative 'spies'
require 'rspec'

module SpeedyTest
  def self.spy
    @spy ||= TracingSpy.new
    # @spy ||= DummySpy.new
  end
end

RSpec.configure do |config|
  config.before(:suite) do
    SpeedyTest.spy.start
  end

  config.after(:suite) do
    SpeedyTest.spy.finish
  end

  config.before(:each) do |example|
    SpeedyTest.spy.test_starts(example)
  end

  config.after(:each) do |example|
    SpeedyTest.spy.test_ends(example)
  end
end
