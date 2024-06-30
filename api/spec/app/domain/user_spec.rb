# frozen_string_literal: true

require 'spec_helper'
require './app/domain/user'

RSpec.describe Domain::User do
  context 'valid user' do
    let(:user) do
      described_class.new(name: 'John', password: '123456')
    end

    it { expect(user.valid?).to be(true) }
  end

  context 'invalid user' do
    let(:user) do
      described_class.new
    end

    it { expect(user.valid?).to be(false) }
  end

  context 'to hash' do
    let(:user) do
      described_class.new(name: 'John')
    end

    it { expect(user.to_hash).to include({ name: 'John', owner: nil, colaborator: nil }) }
  end
end
