require 'spec_helper'

RSpec.describe SpeedyRspec::JsonDependencyManager do
  describe 'new traces' do
    let(:manager) { SpeedyRspec::DependencyManagerFactory.new_dependencies }

    it 'has no dependencies' do
      expect(manager.get_dependencies('foo')).to be_empty
    end

    it 'can add dependencies' do
      manager.add_dependency('foo', 'bar')
      expect(manager.get_dependencies('foo')).to eq(['bar'])
    end
  end

  describe 'existing traces' do
    before do
      SpeedyRspec.trace_file = 'spec/models/test.json'
    end
    let(:manager) { SpeedyRspec::DependencyManagerFactory.load_dependencies }

    it 'has correct dependencies' do
      expect(manager.get_dependencies('foo')).to eq ['bar']
      expect(manager.get_dependencies('bar')).to be_empty
    end
  end
end
