# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/custom_maps/delete'
require './app/domain/custom_map'
require './app/domain/user'

class RepositoryAdapter
  def delete!(custom_map); end
end

RSpec.describe Usecases::CustomMaps::Delete do
  let(:repository_adapter) { RepositoryAdapter.new }
  let(:custom_map_id) { 'abc1234' }
  let(:create_custom_map) do
    described_class.new(id: custom_map_id, repository_adapter:)
  end

  context 'delete a custom map' do
    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:delete!).and_return(nil)

      create_custom_map.call

      expect(repository_adapter).to have_received(:delete!).with(id: custom_map_id)
    end
  end

  context 'delete custom map raise error' do
    before { allow(repository_adapter).to receive(:delete!).and_raise(StandardError) }

    it { expect { create_custom_map.call }.to raise_error(Usecases::CustomMaps::DeleteError) }
  end
end
