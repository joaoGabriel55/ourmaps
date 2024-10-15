# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain::Geometry do
  context 'valid geometry' do
    it { expect { described_class.new(type: 'Point', coordinates: [0, 0]) }.not_to raise_error(Domain::InvalidGeometry) }
    it { expect { described_class.new(type: 'LineString', coordinates: [0, 0]) }.not_to raise_error(Domain::InvalidGeometry) }
    it { expect { described_class.new(type: 'Polygon', coordinates: [0, 0]) }.not_to raise_error(Domain::InvalidGeometry) }
    it { expect { described_class.new(type: 'MultiPoint', coordinates: [0, 0]) }.not_to raise_error(Domain::InvalidGeometry) }
    it { expect { described_class.new(type: 'MultiLineString', coordinates: [0, 0]) }.not_to raise_error(Domain::InvalidGeometry) }
    it { expect { described_class.new(type: 'MultiPolygon', coordinates: [0, 0]) }.not_to raise_error(Domain::InvalidGeometry) }
    it { expect { described_class.new(type: 'GeometryCollection', geometries: [[0, 0]]) }.not_to raise_error(Domain::InvalidGeometry) }
  end

  context 'invalid geometry type' do
    it { expect { described_class.new(type: 'Foint', coordinates: [0, 0]) }.to raise_error(Domain::InvalidGeometry) }
  end

  context 'missing coordinates' do
    it { expect { described_class.new(type: 'Point') }.to raise_error(Domain::InvalidGeometry) }
  end

  context 'missing geometries' do
    it { expect { described_class.new(type: 'GeometryCollection') }.to raise_error(Domain::InvalidGeometry) }
  end

  describe '.to_hash' do
    let(:geometry) do
      described_class.new(type: 'Point', coordinates: [0, 0])
    end

    it { expect(geometry.to_hash).to eq({ type: 'Feature', geometry: { type: 'Point', coordinates: [0, 0] } }) }
  end
end
