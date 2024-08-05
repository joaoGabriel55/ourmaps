# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/users/lookup'
require './app/domain/user'

class RepositoryAdapter
  def lookup!(user); end
end

RSpec.describe Usecases::Users::Lookup do
  let(:repository_adapter) { RepositoryAdapter.new }
  let(:user_id) { 'abc1234' }

  context 'lookup a user' do
    let(:lookup_user) do
      described_class.new(id: user_id, repository_adapter:)
    end

    it 'calls user repository' do
      allow(repository_adapter).to receive(:lookup!).and_return(nil)

      lookup_user.call

      expect(repository_adapter).to have_received(:lookup!).with(id: user_id)
    end
  end

  context 'lookup a user raise error' do
    let(:lookup_user) do
      described_class.new(id: user_id, repository_adapter:)
    end

    before { allow(repository_adapter).to receive(:lookup!).and_raise(StandardError) }

    it { expect { lookup_user.call }.to raise_error(Usecases::Users::LookupError) }
  end
end
