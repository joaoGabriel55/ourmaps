# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/custom_maps/create'
require './app/domain/custom_map'
require './app/domain/user'

RSpec.describe Usecases::CustomMaps::Create do
  let(:repository_adapter) { instance_double('CustomMapRepositoryAdapter') }
  let(:create_custom_map) { described_class.new(params:, repository_adapter:) }
  let(:params) do
    {
      name: 'My Custom Map',
      owner: Domain::User.new(name: 'John', password: '123456')
    }
  end

  context 'create new custom map' do
    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:create!).and_return(nil)

      create_custom_map.call

      expect(repository_adapter).to have_received(:create!).with(include({
        name: 'My Custom Map',
        owner: include({ name: 'John', password: '123456' })
      }))
    end
  end

  context 'create custom map raise error' do
    before { allow(repository_adapter).to receive(:create!).and_raise(StandardError) }

    it { expect { create_custom_map.call }.to raise_error(Usecases::CustomMaps::CreateError) }
  end
end
