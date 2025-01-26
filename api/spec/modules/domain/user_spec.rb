# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain::User do
  context 'valid user' do
    it { expect { described_class.new(id: IdProvider.new.next_id, name: 'John', email: 'j@j.com', password: '123456') }.not_to raise_error(Domain::InvalidUser) }
  end

  context 'invalid user' do
    it { expect { described_class.new(password: '123456') }.to raise_error(Domain::InvalidUser) }
  end

  describe '.to_hash' do
    let(:user) do
      described_class.new(id: IdProvider.new.next_id, name: 'John', email: 'j@j.com', password: '123456')
    end

    it { expect(user.to_hash).to include({ name: 'John', email: 'j@j.com', password: '123456' }) }
  end
end
