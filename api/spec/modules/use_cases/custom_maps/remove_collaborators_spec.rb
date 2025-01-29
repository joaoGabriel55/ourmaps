# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::CustomMaps::RemoveCollaborators do
  let(:adapter) { instance_double("CustomMapRepositoryAdapter") }
  let(:removed_collaborators) { ["123", "456"] }
  let(:custom_map) do
    Domain::CustomMap.new(
      id: "abc1234",
      name: "My Custom Map",
      center: [51.5074, -0.1278],
      visibility: "public",
      owner: Domain::User.new(
        id: "abc1234",
        name: "John",
        email: "j@j.com",
        password: "123456"
      ),
      collaborators: [
        Domain::User.new(
          id: "n123",
          name: "Luke",
          email: "luke@j.com",
          password: "123456"
        ),
        Domain::User.new(
          id: "e123",
          name: "Wayne",
          email: "wayne@j.com",
          password: "123456"
        )
      ]
    )
  end
  let(:remove_custom_map_collaborators) do
    described_class.new(map: custom_map, owner_id: custom_map.owner.id, removed_collaborators:, adapter:)
  end

  context "remove collaborators to a custom map" do
    it "calls custom map repository" do
      allow(adapter).to receive(:remove_collaborators!).and_return(nil)

      remove_custom_map_collaborators.call

      expect(adapter).to have_received(:remove_collaborators!).with(map_id: custom_map.id, removed_collaborators:)
    end
  end

  context "remove collaborators custom map raise error" do
    before { allow(adapter).to receive(:remove_collaborators!).and_raise(StandardError) }

    it { expect { remove_custom_map_collaborators.call }.to raise_error(UseCases::CustomMaps::RemoveCollaboratorsError) }
  end
end
