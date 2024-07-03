# frozen_string_literal: true

require 'spec_helper'
require './app/domain/user'

RSpec.describe Domain::User do
  context 'valid user' do
    let(:user) do
      described_class.new(name: 'John', password: '123456')
    end

    it { expect { described_class.new(name: 'John', password: '123456') }.not_to raise_error(Domain::InvalidUser) }
  end

  context 'invalid user' do
    let(:user) do
      described_class.new
    end

    it { expect { described_class.new }.to raise_error(Domain::InvalidUser) }
  end

  describe '.to_hash' do
    let(:user) do
      described_class.new(name: 'John', password: '123456')
    end

    it { expect(user.to_hash).to include({ name: 'John', password: '123456', owner: nil, colaborator: nil }) }
  end
end
