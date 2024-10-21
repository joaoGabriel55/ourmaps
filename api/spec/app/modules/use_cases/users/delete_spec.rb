# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::Users::Delete do
  let(:repository_adapter) { instance_double('UsersRepositoryAdapter') }
  let(:user_id) { 'abc1234' }
  let(:delete_user) do
    described_class.new(id: user_id, repository_adapter:)
  end

  context 'delete a user' do
    it 'calls user repository' do
      allow(repository_adapter).to receive(:delete!).and_return(nil)

      delete_user.call

      expect(repository_adapter).to have_received(:delete!).with(id: user_id)
    end
  end

  context 'delete user raise error' do
    before { allow(repository_adapter).to receive(:delete!).and_raise(StandardError) }

    it { expect { delete_user.call }.to raise_error(UseCases::Users::DeleteError) }
  end
end
