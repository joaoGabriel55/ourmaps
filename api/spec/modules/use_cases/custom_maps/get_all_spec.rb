# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::CustomMaps::GetAll do
  let(:repository_adapter) { instance_double('CustomMapRepositoryAdapter') }
  let(:owner_id) { 'abc1234' }
  let(:get_all_maps) do
    described_class.new(owner_id:, repository_adapter:)
  end

  context 'get all custom maps' do
    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:get_all!).and_return([])

      get_all_maps.call

      expect(repository_adapter).to have_received(:get_all!).with(owner_id:, paginator: { per_page: 10, page: 1 })
    end
  end

  context 'get all custom maps raise error' do
    before { allow(repository_adapter).to receive(:get_all!).and_raise(StandardError) }

    it { expect { get_all_maps.call }.to raise_error(UseCases::CustomMaps::GetAllError) }
  end
end
