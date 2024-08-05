# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/custom_maps/lookup'
require './app/domain/custom_map'

class RepositoryAdapter
  def lookup!(custom_map); end
end

RSpec.describe Usecases::CustomMaps::Lookup do
  let(:repository_adapter) { RepositoryAdapter.new }
  let(:custom_map_id) { 'abc1234' }

  context 'lookup a custom map' do
    let(:lookup_custom_map) do
      described_class.new(id: custom_map_id, repository_adapter:)
    end

    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:lookup!).and_return(nil)

      lookup_custom_map.call

      expect(repository_adapter).to have_received(:lookup!).with(id: custom_map_id)
    end
  end

  context 'lookup a custom map raise error' do
    let(:lookup_custom_map) do
      described_class.new(id: custom_map_id, repository_adapter:)
    end

    before { allow(repository_adapter).to receive(:lookup!).and_raise(StandardError) }

    it { expect { lookup_custom_map.call }.to raise_error(Usecases::CustomMaps::LookupError) }
  end
end
