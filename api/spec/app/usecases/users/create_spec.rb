# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/users/create'
require './app/adapters/user_repository'

class RepositoryAdapter
  def create!(user)
    user
  end
end

RSpec.describe Usecases::Users::Create do
  let(:repository_adapter) { RepositoryAdapter.new }

  context 'create new user' do
    let(:create_user) do
      described_class.new(params: { name: 'John', password: '123456' }, repository_adapter:)
    end

    it 'calls user repository' do
      allow(repository_adapter).to receive(:create!).and_return(nil)

      create_user.call

      expect(repository_adapter).to have_received(:create!).with(include({
        name: 'John', password: '123456', owner: nil, colaborator: nil
      }))
    end
  end

  context 'invalid user' do
    let(:create_user) do
      described_class.new(params: { name: '' }, repository_adapter:)
    end

    it { expect { create_user.call }.to raise_error(Usecases::Users::InvalidUser) }
  end
end
