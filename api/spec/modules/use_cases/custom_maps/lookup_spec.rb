# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::CustomMaps::Lookup do
  let(:repository_adapter) { instance_double('CustomMapRepositoryAdapter') }
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

    it { expect { lookup_custom_map.call }.to raise_error(UseCases::CustomMaps::LookupError) }
  end
end
