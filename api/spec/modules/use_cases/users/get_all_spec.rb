# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UseCases::Users::GetAll do
  let(:repository_adapter) { instance_double('UsersRepositoryAdapter') }
  let(:get_all_users) do
    described_class.new(repository_adapter:)
  end

  context 'get all users' do
    it 'calls user repository' do
      allow(repository_adapter).to receive(:get_all!).and_return([])

      get_all_users.call

      expect(repository_adapter).to have_received(:get_all!).with(paginator: { per_page: 10, page: 1 })
    end
  end

  context 'get all users raise error' do
    before { allow(repository_adapter).to receive(:get_all!).and_raise(StandardError) }

    it { expect { get_all_users.call }.to raise_error(UseCases::Users::GetAllError) }
  end
end
