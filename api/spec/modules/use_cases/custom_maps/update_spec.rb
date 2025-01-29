# frozen_string_literal: true

require "rails_helper"

RSpec.describe UseCases::CustomMaps::Update do
  let(:adapter) { instance_double("CustomMapRepositoryAdapter") }
  let(:update_custom_map) { described_class.new(params:, adapter:) }
  let(:params) do
    {
      id: IdProvider.new.next_id,
      name: "My Custom Map",
      center: [51.5074, -0.1278],
      owner: Domain::User.new(id: IdProvider.new.next_id, name: "John", email: "j@j.com", password: "123456"),
      visibility: "public"
    }
  end

  context "update custom map" do
    it "calls custom map repository" do
      allow(adapter).to receive(:update!).and_return(nil)

      update_custom_map.call

      expect(adapter).to have_received(:update!).with(include({
        name: params[:name],
        center: params[:center]
      }))
    end
  end

  context "update custom map raise error" do
    before { allow(adapter).to receive(:update!).and_raise(StandardError) }

    it { expect { update_custom_map.call }.to raise_error(UseCases::CustomMaps::UpdateError) }
  end

  context "update custom map without entity id raise error" do
    let(:params) { {id: nil} }

    it { expect { update_custom_map.call }.to raise_error(UseCases::CustomMaps::UpdateError) }
  end
end
