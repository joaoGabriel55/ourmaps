# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/users/create'
require './app/adapters/user_repository'

RSpec.describe Users::Create do
  context 'create new user' do
    let(:create_user) do
      described_class.new(params: { name: 'John', password: '123456' })
    end

    it 'calls user repository' do
      allow(UserRepository).to receive(:create!).and_return(nil)

      create_user.call

      expect(UserRepository).to have_received(:create!).with(include({
        name: 'John', password: '123456', owner: nil, colaborator: nil
      }))
    end
  end

  context 'invalid user' do
    let(:create_user) do
      described_class.new(params: { name: '' })
    end

    it { expect { create_user.call }.to raise_error(Users::InvalidUser) }
  end
end
