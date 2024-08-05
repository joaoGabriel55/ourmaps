# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/users/get_all'
require './app/domain/user'

class RepositoryAdapter
  def get_all!(paginator:); end
end

RSpec.describe Usecases::Users::GetAll do
  let(:repository_adapter) { RepositoryAdapter.new }
  let(:get_all_users) do
    described_class.new(repository_adapter:)
  end

  context 'get all users' do
    it 'calls user repository' do
      allow(repository_adapter).to receive(:get_all!).and_return(nil)

      get_all_users.call

      expect(repository_adapter).to have_received(:get_all!).with(paginator: { cursor: nil, page_size: 10 })
    end
  end

  context 'get all users raise error' do
    before { allow(repository_adapter).to receive(:get_all!).and_raise(StandardError) }

    it { expect { get_all_users.call }.to raise_error(Usecases::Users::GetAllError) }
  end
end
