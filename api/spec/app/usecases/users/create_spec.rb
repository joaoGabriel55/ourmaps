# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/users/create'
require './app/domain/user'

RSpec.describe Usecases::Users::Create do
  let(:repository_adapter) { instance_double('UsersRepositoryAdapter') }

  context 'create new user' do
    let(:create_user) do
      described_class.new(params: { name: 'John', password: '123456' },
        repository_adapter:)
    end

    it 'calls user repository' do
      allow(repository_adapter).to receive(:create!).and_return(nil)

      create_user.call

      expect(repository_adapter).to have_received(:create!).with(include({
        name: 'John', password: '123456'
      }))
    end
  end

  context 'create user raise error' do
    let(:create_user) do
      described_class.new(params: { name: '' }, repository_adapter:)
    end

    it { expect { create_user.call }.to raise_error(Usecases::Users::CreateError) }
  end
end
