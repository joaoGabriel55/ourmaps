# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::Users::Update do
  let(:repository_adapter) { instance_double('UsersRepositoryAdapter') }
  let(:update_user) { described_class.new(params:, repository_adapter:) }
  let(:params) do
    {
      id: 'abc1234',
      name: 'My Custom Map',
      password: '123456'
    }
  end

  context 'update user' do
    it 'calls user repository' do
      allow(repository_adapter).to receive(:update!).and_return(nil)

      update_user.call

      expect(repository_adapter).to have_received(:update!).with(include({
        name: params[:name],
        password: params[:password]
      }))
    end
  end

  context 'update user raise error' do
    before { allow(repository_adapter).to receive(:update!).and_raise(StandardError) }

    it { expect { update_user.call }.to raise_error(UseCases::Users::UpdateError) }
  end

  context 'update user without entity id raise error' do
    let(:params) { { id: nil } }

    it { expect { update_user.call }.to raise_error(UseCases::Users::UpdateError) }
  end
end
