# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain::CustomMap do
  context 'valid custom map' do
    it do
      expect do
        described_class.new(
          id: 'abc1234',
          name: 'My Custom Map',
          owner: Domain::User.new(name: 'John', password: '123456'),
          center: [ 51.5074, -0.1278 ]
        )
      end.not_to raise_error(Domain::InvalidCustomMap)
    end
  end

  context 'invalid custom map' do
    it { expect { described_class.new(name: 'My Custom Map') }.to raise_error(Domain::InvalidCustomMap) }

    context 'when center is invalid' do
      it { expect { described_class.new(name: 'My Custom Map', center: 'invalid') }.to raise_error(Domain::InvalidCustomMap) }
    end
  end

  describe '.to_hash' do
    let(:custom_map) do
      described_class.new(
        id: 'abc1234',
        name: 'My Custom Map',
        center: [ 51.5074, -0.1278 ],
        owner: Domain::User.new(id: IdProvider.new.next_id, name: 'John', password: '123456'),
        colaborators: [ Domain::User.new(id: IdProvider.new.next_id, name: 'Luke', password: '123456') ]
      ).to_hash
    end

    it { expect(custom_map[:id]).to eq('abc1234') }
    it { expect(custom_map[:name]).to eq('My Custom Map') }
    it { expect(custom_map[:owner][:name]).to eq('John') }
    it { expect(custom_map[:center]).to eq([ 51.5074, -0.1278 ]) }
    it { expect(custom_map[:colaborators][0][:name]).to eq('Luke') }
  end
end
