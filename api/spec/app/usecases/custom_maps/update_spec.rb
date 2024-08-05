# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/custom_maps/update'
require './app/domain/custom_map'
require './app/domain/user'

class RepositoryAdapter
  def update!(custom_map); end
end

RSpec.describe Usecases::CustomMaps::Update do
  let(:repository_adapter) { RepositoryAdapter.new }
  let(:create_custom_map) { described_class.new(params:, repository_adapter:) }
  let(:params) do
    {
      id: 'abc1234',
      name: 'My Custom Map',
      owner: Domain::User.new(name: 'John', password: '123456')
    }
  end

  context 'update new custom map' do
    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:update!).and_return(nil)

      create_custom_map.call

      expect(repository_adapter).to have_received(:update!).with(include({
        name: params[:name],
        owner: include({ name: params[:owner].name, password: params[:owner].password })
      }))
    end
  end

  context 'update custom map raise error' do
    before { allow(repository_adapter).to receive(:update!).and_raise(StandardError) }

    it { expect { create_custom_map.call }.to raise_error(Usecases::CustomMaps::UpdateError) }
  end

  context 'update custom map without entity id raise error' do
    let(:params) { { id: nil } }

    it { expect { create_custom_map.call }.to raise_error(Usecases::CustomMaps::UpdateError) }
  end
end
