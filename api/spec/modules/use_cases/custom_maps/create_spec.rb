# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::CustomMaps::Create do
  let(:repository_adapter) { instance_double('CustomMapRepositoryAdapter') }
  let(:create_custom_map) { described_class.new(params:, repository_adapter:) }
  let(:params) do
    {
      id: 'abc1234',
      name: 'My Custom Map',
      center: [ 51.5074, -0.1278 ],
      owner: Domain::User.new(id: IdProvider.new.next_id, name: 'John', password: '123456'),
      visibility: 'public'
    }
  end

  context 'create new custom map' do
    it 'calls custom map repository' do
      allow(repository_adapter).to receive(:create!).and_return(
        Domain::CustomMap.new(
          id: params[:id],
          name: params[:name],
          owner: params[:owner],
          center: params[:center],
          visibility: params[:visibility]
        )
      )

      create_custom_map.call

      expect(repository_adapter).to have_received(:create!).with(include({
        name: 'My Custom Map',
        owner: include({ name: 'John', password: '123456' })
      }))
    end
  end

  context 'create custom map raise error' do
    before { allow(repository_adapter).to receive(:create!).and_raise(StandardError) }

    it { expect { create_custom_map.call }.to raise_error(UseCases::CustomMaps::CreateError) }
  end
end
