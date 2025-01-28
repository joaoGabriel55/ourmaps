require "rails_helper"

RSpec.describe "Authentications", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:token) { JsonWebToken.encode({user_id: user.id}) }

  before(:each) do
    @headers = {"Authorization" => "Bearer #{token}"}
  end

  context "when token is invalid" do
    it "returns 401 unauthorized status" do
      get "/users", headers: {"Authorization" => "Bearer F"}

      expect(response.status).to eq(401)
    end

    it "returns error message" do
      get "/users", headers: {"Authorization" => "Bearer F"}

      expect(response.body).to include("Invalid token")
    end
  end

  context "when user is authenticated" do
    it "returns 200 status" do
      get "/users", headers: @headers

      expect(response.status).to eq(200)
    end
  end
end
