# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::CustomMaps::Lookup do
  let(:adapter) { instance_double("CustomMapRepositoryAdapter") }
  let(:custom_map_id) { "abc1234" }
  let(:current_user_id) { "abc1234" }

  context "lookup a custom map" do
    let(:lookup_custom_map) do
      described_class.new(id: custom_map_id, current_user_id:, adapter:)
    end

    it "calls custom map repository" do
      allow(adapter).to receive(:lookup!).and_return(
        Domain::CustomMap.new(
          id: custom_map_id,
          name: "My Custom Map",
          center: [51.5074, -0.1278],
          visibility: "public",
          owner: Domain::User.new(
            id: current_user_id,
            name: "John",
            email: "j@j.com",
            password: "123456"
          )
        )
      )

      lookup_custom_map.call

      expect(adapter).to have_received(:lookup!).with(id: custom_map_id)
    end
  end

  context "lookup a custom map raise error" do
    let(:lookup_custom_map) do
      described_class.new(id: custom_map_id, current_user_id:, adapter:)
    end

    before { allow(adapter).to receive(:lookup!).and_raise(StandardError) }

    it { expect { lookup_custom_map.call }.to raise_error(UseCases::CustomMaps::LookupError) }
  end

  context "when private custom map owner id is not the same of current user" do
    let(:lookup_custom_map) do
      described_class.new(id: custom_map_id, current_user_id: "def1234", adapter:)
    end

    it "raises not map owner error" do
      allow(adapter).to receive(:lookup!).and_return(
        Domain::CustomMap.new(
          id: custom_map_id,
          name: "My Custom Map",
          center: [51.5074, -0.1278],
          visibility: "private",
          owner: Domain::User.new(
            id: IdProvider.new.next_id,
            name: "John",
            email: "j@j.com",
            password: "123456"
          )
        )
      )

      expect { lookup_custom_map.call }.to raise_error(UseCases::CustomMaps::NotMapOwnerError)
    end
  end

  context "when private custom map owner id is the same of current user" do
    let(:lookup_custom_map) do
      described_class.new(id: custom_map_id, current_user_id:, adapter:)
    end

    it "does not raise not map owner error" do
      allow(adapter).to receive(:lookup!).and_return(
        Domain::CustomMap.new(
          id: custom_map_id,
          name: "My Custom Map",
          center: [51.5074, -0.1278],
          visibility: "private",
          owner: Domain::User.new(
            id: current_user_id,
            name: "John",
            email: "j@j.com",
            password: "123456"
          )
        )
      )

      expect { lookup_custom_map.call }.not_to raise_error
    end
  end
end
