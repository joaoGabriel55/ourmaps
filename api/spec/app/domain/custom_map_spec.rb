# frozen_string_literal: true

require 'spec_helper'
require './app/domain/custom_map'
require './app/domain/user'

RSpec.describe Domain::CustomMap do
  context 'valid custom map' do
    it do
      expect do
        described_class.new(
          id: 'abc1234',
          name: 'My Custom Map',
          owner: Domain::User.new(name: 'John', password: '123456')
        )
      end.not_to raise_error(Domain::InvalidCustomMap)
    end
  end

  context 'invalid custom map' do
    it { expect { described_class.new(name: 'My Custom Map') }.to raise_error(Domain::InvalidCustomMap) }
  end

  describe '.to_hash' do
    let(:custom_map) do
      described_class.new(
        id: 'abc1234',
        name: 'My Custom Map',
        owner: Domain::User.new(name: 'John', password: '123456'),
        colaborators: [Domain::User.new(name: 'Luke', password: '123456')]
      ).to_hash
    end

    it { expect(custom_map[:id]).to eq('abc1234') }
    it { expect(custom_map[:name]).to eq('My Custom Map') }
    it { expect(custom_map[:owner][:name]).to eq('John') }
    it { expect(custom_map[:colaborators][0][:name]).to eq('Luke') }
  end
end
