# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::CustomMaps::Delete do
  let(:repository_adapter) { instance_double("CustomMapRepositoryAdapter") }
  let(:custom_map_id) { "abc1234" }
  let(:delete_custom_map) do
    described_class.new(id: custom_map_id, repository_adapter:)
  end

  context "delete a custom map" do
    it "calls custom map repository" do
      allow(repository_adapter).to receive(:delete!).and_return(nil)

      delete_custom_map.call

      expect(repository_adapter).to have_received(:delete!).with(id: custom_map_id)
    end
  end

  context "delete custom map raise error" do
    before { allow(repository_adapter).to receive(:delete!).and_raise(StandardError) }

    it { expect { delete_custom_map.call }.to raise_error(UseCases::CustomMaps::DeleteError) }
  end
end
