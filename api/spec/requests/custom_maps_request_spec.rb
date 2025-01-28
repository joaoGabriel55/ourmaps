# frozen_string_literal: true

require "rails_helper"

RSpec.describe CustomMapsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { JsonWebToken.encode({user_id: user.id}) }

  before(:each) do
    @headers = {"Authorization" => "Bearer #{token}"}
  end

  describe "get all maps" do
    before do
      FactoryBot.create_list(:custom_map, 2, owner:)
    end

    let!(:owner) { FactoryBot.create(:user, name: "John", password: "123456") }

    it "returns 200 ok status" do
      get "/custom_maps?owner_id=" + owner.id, headers: @headers

      expect(response.status).to eq(200)
    end

    context "when owner id is not provided" do
      it "returns 400 bad request status" do
        get "/custom_maps", headers: @headers

        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to include({"error" => "owner_id is required"})
      end
    end

    context "when owner id is not found" do
      it "returns 404 not found status" do
        get "/custom_maps?owner_id=abc212", headers: @headers

        expect(response.status).to eq(404)
      end
    end

    it "returns the 2 custom maps" do
      get "/custom_maps?owner_id=" + owner.id, headers: @headers

      expect(JSON.parse(response.body).size).to eq(2)
    end

    context "when visibility filter is provided" do
      let!(:second_owner) { FactoryBot.create(:user, name: "Carlos") }

      before do
        FactoryBot.create_list(:custom_map, 2, owner: second_owner, visibility: "public")
        FactoryBot.create_list(:custom_map, 10, owner: second_owner, visibility: "private")
      end

      it "returns 200 ok status" do
        get "/custom_maps?owner_id=" + second_owner.id + "&visibility=private", headers: @headers

        expect(response.status).to eq(200)
      end

      it "returns the 2 public custom maps" do
        get "/custom_maps?owner_id=" + second_owner.id + "&visibility=public", headers: @headers

        expect(JSON.parse(response.body).size).to eq(2)
      end

      it "returns the 10 private custom maps" do
        get "/custom_maps?owner_id=" + second_owner.id + "&visibility=private", headers: @headers

        expect(JSON.parse(response.body).size).to eq(10)
      end
    end
  end

  describe "get map by id" do
    let!(:owner) { FactoryBot.create(:user, name: "John", password: "123456") }
    let!(:custom_map) { FactoryBot.create(:custom_map, owner:) }

    it "returns 200 ok status" do
      get "/custom_maps/#{custom_map.id}", headers: @headers

      expect(response.status).to eq(200)
    end

    it "returns custom map" do
      get "/custom_maps/#{custom_map.id}", headers: @headers

      response_body = JSON.parse(response.body)

      expect(response_body).to include({
        "id" => String,
        "name" => custom_map.name,
        "center" => [custom_map.lat_center, custom_map.lng_center],
        "description" => custom_map.description
      })
      expect(response_body["content"]).to eq(custom_map.content)
    end

    context "when custom map s not found" do
      it "returns 404 not found status" do
        get "/custom_maps/abc212", headers: @headers

        expect(response.status).to eq(404)
      end
    end

    context "when private custom map owner id is not the same of current user" do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { JsonWebToken.encode({user_id: user.id}) }
      let!(:custom_map) { FactoryBot.create(:custom_map, owner: user, visibility: "private") }
      let(:user_two) { FactoryBot.create(:user) }
      let(:token_two) { JsonWebToken.encode({user_id: user_two.id}) }
      let(:header_from_user_two) { {"Authorization" => "Bearer #{token_two}"} }

      it "returns 403 forbidden status" do
        get "/custom_maps/#{custom_map.id}", headers: header_from_user_two

        expect(response.status).to eq(403)
      end

      it "returns error message" do
        get "/custom_maps/#{custom_map.id}", headers: header_from_user_two

        expect(JSON.parse(response.body)).to include({
          "error" => "You don't have permission to access this map"
        })
      end
    end

    context "when private custom map owner id is the same of current user" do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { JsonWebToken.encode({user_id: user.id}) }
      let!(:custom_map) { FactoryBot.create(:custom_map, owner: user, visibility: "private") }

      it "returns 200 ok status" do
        get "/custom_maps/#{custom_map.id}", headers: {"Authorization" => "Bearer #{token}"}

        expect(response.status).to eq(200)
      end
    end
  end

  describe "create new custom map" do
    let!(:owner) { FactoryBot.create(:user, name: "John", password: "123456") }
    let(:body) {
      {
        name: "New Custom Map",
        owner_id: owner.id,
        center: [51.5074, -0.1278],
        description: "New Custom Map Description",
        visibility: "public"
      }
    }

    it "returns 201 created status" do
      post "/custom_maps", params: body, as: :json, headers: @headers

      expect(response.status).to eq(201)
    end

    it "returns created custom map" do
      post "/custom_maps", params: body, as: :json, headers: @headers

      expect(JSON.parse(response.body)["name"]).to eq(body[:name])
    end

    context "when a geojson content is provided" do
      let(:body) {
        {
          name: "New Custom Map",
          owner_id: owner.id,
          description: "New Custom Map Description",
          visibility: "public",
          center: [51.5074, -0.1278],
          content: {
            type: "Feature",
            geometry: {
              type: "Point",
              coordinates: [125.6, 10.1]
            },
            properties: {
              name: "Dinagat Islands"
            }
          }
        }
      }

      it "returns 201 created status" do
        post "/custom_maps", params: body, as: :json, headers: @headers

        expect(response.status).to eq(201)
      end

      it "returns created custom map content" do
        post "/custom_maps", params: body, as: :json, headers: @headers

        expect(JSON.parse(response.body)["content"]).to eq({
          "geometry" => {
            "coordinates" => [125.6, 10.1], "type" => "Point"
          },
          "properties" => {"name" => "Dinagat Islands"},
          "type" => "Feature"
        })
      end

      it "changes the number of custom maps on database" do
        expect do
          post "/custom_maps", params: body, as: :json, headers: @headers
        end.to change { CustomMap.count }.by(1)
      end
    end
  end

  describe "update custom map" do
    let!(:owner) { FactoryBot.create(:user, name: "John", password: "123456") }
    let!(:custom_map) { FactoryBot.create(:custom_map, owner:) }
    let(:body) {
      {
        name: "Updated Custom Map",
        center: [51.5074, -0.1278],
        description: "Updated Custom Map Description",
        visibility: "public"
      }
    }

    it "returns 200 ok status" do
      patch "/custom_maps/#{custom_map.id}", params: body, as: :json, headers: @headers

      expect(response.status).to eq(200)
    end

    it "returns updated custom map" do
      patch "/custom_maps/#{custom_map.id}", params: body, as: :json, headers: @headers

      expect(JSON.parse(response.body)["name"]).to eq(body[:name])
    end

    context "when custom map not found" do
      it "returns 404 not found status" do
        patch "/custom_maps/abc212", params: body, as: :json, headers: @headers

        expect(response.status).to eq(404)
      end
    end

    context "when private custom map owner id is not the same of current user" do
      let(:user) { FactoryBot.create(:user) }
      let!(:custom_map) { FactoryBot.create(:custom_map, owner: user, visibility: "private") }
      let(:body) {
        {
          name: "Updated Custom Map",
          center: [51.5074, -0.1278],
          description: "Updated Custom Map Description",
          visibility: "private"
        }
      }
      let(:user_two) { FactoryBot.create(:user) }
      let(:token_two) { JsonWebToken.encode({user_id: user_two.id}) }
      let(:header_from_user_two) { {"Authorization" => "Bearer #{token_two}"} }

      it "returns 403 forbidden status" do
        patch "/custom_maps/#{custom_map.id}", params: body, as: :json, headers: header_from_user_two

        expect(response.status).to eq(403)
      end

      it "returns error message" do
        patch "/custom_maps/#{custom_map.id}", params: body, as: :json, headers: header_from_user_two

        expect(JSON.parse(response.body)).to include({
          "error" => "You don't have permission to access this map"
        })
      end
    end

    context "when private custom map owner id is the same of current user" do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { JsonWebToken.encode({user_id: user.id}) }
      let!(:custom_map) { FactoryBot.create(:custom_map, owner: user, visibility: "private") }
      let(:body) {
        {
          name: "Updated Custom Map",
          center: [51.5074, -0.1278],
          description: "Updated Custom Map Description",
          visibility: "private"
        }
      }

      it "returns 200 ok status" do
        patch "/custom_maps/#{custom_map.id}", params: body, as: :json, headers: {"Authorization" => "Bearer #{token}"}

        expect(response.status).to eq(200)
      end
    end
  end

  describe "delete custom map" do
    let!(:owner) { FactoryBot.create(:user, name: "John", password: "123456") }
    let!(:custom_map) { FactoryBot.create(:custom_map, owner:) }

    it "returns 204 no content status" do
      delete "/custom_maps/#{custom_map.id}", headers: @headers

      expect(response.status).to eq(204)
    end

    context "when custom map not found" do
      it "returns 404 not found status" do
        delete "/custom_maps/abc212", headers: @headers

        expect(response.status).to eq(404)
      end
    end

    context "when private custom map owner id is not the same of current user" do
      let(:user) { FactoryBot.create(:user) }
      let!(:custom_map) { FactoryBot.create(:custom_map, owner: user, visibility: "private") }
      let(:user_two) { FactoryBot.create(:user) }
      let(:token_two) { JsonWebToken.encode({user_id: user_two.id}) }
      let(:header_from_user_two) { {"Authorization" => "Bearer #{token_two}"} }

      it "returns 403 forbidden status" do
        delete "/custom_maps/#{custom_map.id}", headers: header_from_user_two

        expect(response.status).to eq(403)
      end

      it "returns error message" do
        delete "/custom_maps/#{custom_map.id}", headers: header_from_user_two

        expect(JSON.parse(response.body)).to include({
          "error" => "You don't have permission to access this map"
        })
      end
    end

    context "when private custom map owner id is the same of current user" do
      let(:user) { FactoryBot.create(:user) }
      let(:token) { JsonWebToken.encode({user_id: user.id}) }

      it "returns 200 ok status" do
        delete "/custom_maps/#{custom_map.id}", headers: {"Authorization" => "Bearer #{token}"}

        expect(response.status).to eq(204)
      end
    end
  end
end
