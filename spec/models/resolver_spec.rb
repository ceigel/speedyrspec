require 'spec_helper'
require 'pry-byebug'

RSpec.describe SpeedyRspec::Resolver do
  before do
    SpeedyRspec.trace_file = 'spec/models/test.json'
    allow(File).to receive(:absolute_path) { |arg| arg }
  end

  let(:resolver) { SpeedyRspec::Resolver.new }

  it 'returns tests for file' do
    expect(resolver.get_tests(['foo'])).to eq(['bar'])
    expect(resolver.get_tests(['foo', 'baz'])).to eq(['bar'])
  end
end
