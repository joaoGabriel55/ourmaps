# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/custom_maps/get_all'
require './app/domain/custom_map'

RSpec.describe Usecases::CustomMaps::GetAll do
  let(:repository_adapter) { instance_double('CustomMapRepositoryAdapter') }
  let(:owner_id) { 'abc1234' }
  let(:get_all_maps) do
    described_class.new(owner_id:, repository_adapter:)
  end

  context 'get all custom maps' do
    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:get_all!).and_return(nil)

      get_all_maps.call

      expect(repository_adapter).to have_received(:get_all!).with(owner_id:, paginator: { cursor: nil, page_size: 10 })
    end
  end

  context 'get all custom maps raise error' do
    before { allow(repository_adapter).to receive(:get_all!).and_raise(StandardError) }

    it { expect { get_all_maps.call }.to raise_error(Usecases::CustomMaps::GetAllError) }
  end
end
