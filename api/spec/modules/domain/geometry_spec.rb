# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::Geometry do
  context "valid geometry" do
    let(:geometry) do
      {
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
    end

    it { expect { described_class.new(geometry:) }.not_to raise_error(Domain::InvalidGeometry) }
  end

  context "invalid geometry" do
    let(:geometry) do
      {
        type: "FeatureCollection22",
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
    end

    it { expect { described_class.new(geometry:) }.to raise_error(Domain::InvalidGeometry) }
  end

  describe ".to_hash" do
    let(:geometry) do
      {
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
    end

    it { expect(described_class.new(geometry:).to_hash).to eq(geometry) }
  end
end
