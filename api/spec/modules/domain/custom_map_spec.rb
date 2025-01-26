# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain::CustomMap do
  context 'valid custom map' do
    it do
      expect do
        described_class.new(
          id: 'abc1234',
          name: 'My Custom Map',
          owner: Domain::User.new(name: 'John', email: 'j@j.com', password: '123456'),
          center: [ 51.5074, -0.1278 ],
          visibility: 'private'
        )
      end.not_to raise_error(Domain::InvalidCustomMap)
    end
  end

  context 'invalid custom map' do
    it { expect { described_class.new(name: 'My Custom Map') }.to raise_error(Domain::InvalidCustomMap) }

    context 'when center is invalid' do
      it { expect { described_class.new(name: 'My Custom Map', center: 'invalid') }.to raise_error(Domain::InvalidCustomMap) }
    end

    context 'when map content is invalid' do
      it { expect { described_class.new(name: 'My Custom Map', content: 'invalid') }.to raise_error(Domain::InvalidCustomMap) }
    end

    context 'when visibility is invalid' do
      it { expect { described_class.new(name: 'My Custom Map', visibility: 'invalid') }.to raise_error(Domain::InvalidCustomMap) }
    end
  end

  describe '.to_hash' do
    let(:custom_map) do
      described_class.new(
        id: 'abc1234',
        name: 'My Custom Map',
        center: [ 51.5074, -0.1278 ],
        owner: Domain::User.new(id: IdProvider.new.next_id, name: 'John', email: 'j@j.com', password: '123456'),
        collaborators: [ Domain::User.new(id: IdProvider.new.next_id, name: 'Luke', email: 'j@j.com', password: '123456') ],
        visibility: 'public',
        content: Domain::Geometry.new(
          geometry: {
            type: "FeatureCollection",
            features: [
              {
                type: "Feature",
                properties: {},
                geometry: {
                  coordinates: [
                    14.467459460702372,
                    50.065357461330194
                  ],
                  type: "Point"
                }
              }
            ]
          }
        )
      ).to_hash
    end

    it { expect(custom_map[:id]).to eq('abc1234') }
    it { expect(custom_map[:name]).to eq('My Custom Map') }
    it { expect(custom_map[:owner][:name]).to eq('John') }
    it { expect(custom_map[:center]).to eq([ 51.5074, -0.1278 ]) }
    it { expect(custom_map[:collaborators][0][:name]).to eq('Luke') }
    it { expect(custom_map[:visibility]).to eq('public') }
    it { expect(custom_map[:content]).to eq({
      features: [
        {
          geometry: {
            coordinates: [ 14.467459460702372, 50.065357461330194 ],
            type: "Point"
          },
          properties: {},
          type: "Feature"
        }
      ],
      type: "FeatureCollection"
    }) }
  end
end
