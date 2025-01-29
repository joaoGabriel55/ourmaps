# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::CustomMaps::AddCollaborators do
  let(:repository_adapter) { instance_double("CustomMapRepositoryAdapter") }
  let(:collaborators) { ["123", "456"] }
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
      )
    )
  end

  context "add collaborators to a custom map" do
    let(:add_custom_map_collaborators) do
      described_class.new(map: custom_map, owner_id: custom_map.owner.id, collaborators:, repository_adapter:)
    end

    it "calls custom map repository" do
      allow(repository_adapter).to receive(:add_collaborators!).and_return(nil)

      add_custom_map_collaborators.call

      expect(repository_adapter).to have_received(:add_collaborators!).with(map_id: custom_map.id, collaborators:)
    end
  end

  context "add collaborators custom map raise error" do
    let(:add_custom_map_collaborators) do
      described_class.new(map: custom_map, owner_id: custom_map.owner.id, collaborators: [custom_map.owner.id], repository_adapter:)
    end

    before { allow(repository_adapter).to receive(:add_collaborators!).and_raise(StandardError) }

    it { expect { add_custom_map_collaborators.call }.to raise_error(UseCases::CustomMaps::NotAddYourselfError) }
  end
end
