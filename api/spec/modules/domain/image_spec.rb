# frozen_string_literal: true

require "rails_helper"

RSpec.describe Domain::Image do
  context "valid image" do
    it { expect { described_class.new(id: "abc124", url: "https://example.com") }.not_to raise_error(Domain::InvalidImage) }
  end

  context "invalid image" do
    it { expect { described_class.new(id: "abc124", url: nil) }.to raise_error(Domain::InvalidImage) }
  end

  describe ".to_hash" do
    let(:image) do
      described_class.new(id: "abc124", url: "https://example.com")
    end

    it { expect(image.to_hash).to eq({id: "abc124", url: "https://example.com", uploaded_at: image.uploaded_at}) }
  end
end
