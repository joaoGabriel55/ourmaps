# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Domain::MapContent do
  let(:geometry) { Domain::Geometry.new(type: 'Point', coordinates: [ 0, 0 ]) }
  let(:image) { Domain::Image.new(id: 'abc123', url: 'https://example.com') }

  context 'valid map content' do
    it { expect { described_class.new(id: 'abc124', image:, geometry:) }.not_to raise_error(Domain::InvalidMapContent) }
  end

  context 'missing geometry' do
    it { expect { described_class.new(id: 'abc124', image: nil) }.to raise_error(Domain::InvalidMapContent) }
  end

  describe '.to_hash' do
    let(:map_content) do
      described_class.new(id: 'abc124', image:, geometry:)
    end

    it { expect(map_content.to_hash).to eq({ id: 'abc124', image: image.to_hash, geometry: geometry.to_hash }) }
  end
end
