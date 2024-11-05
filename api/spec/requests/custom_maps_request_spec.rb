# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CustomMapsController, type: :request do
  describe 'get all maps' do
    before do
      FactoryBot.create_list(:custom_map_repository, 2, owner:)
    end

    let!(:owner) { FactoryBot.create(:user_repository, name: 'John', password: '123456') }

    it 'returns 200 ok status' do
      get '/custom_maps?owner_id=' + owner.id

      expect(response.status).to eq(200)
    end

    context 'when owner id is not provided' do
      it 'returns 400 bad request status' do
        get '/custom_maps'

        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to include({ 'error' => 'owner_id is required' })
      end
    end

    context 'when owner id is not found' do
      it 'returns 404 not found status' do
        get '/custom_maps?owner_id=abc212'

        expect(response.status).to eq(404)
      end
    end

    # it 'returns all custom maps' do
    #   get '/custom_maps?owner_id=' + owner_id

    #   expect(JSON.parse(response.body)).to include({
    #     'id' => String,
    #     'name' => params[:name],
    #     'createdAt' => String,
    #     'updatedAt' => String
    #   })
    # end

    # it 'returns custom maps count' do
    #   get '/users'

    #   expect(JSON.parse(response.body).size).to eq(1)
    # end
  end

  describe 'create new custom map' do
    let!(:owner) { FactoryBot.create(:user_repository, name: 'John', password: '123456') }
    let(:body) { {
      name: 'New Custom Map',
      owner_id: owner.id,
      description: 'New Custom Map Description'
    } }

    it 'returns 201 created status' do
      post '/custom_maps', params: body

      expect(response.status).to eq(201)
    end

    it 'returns created user' do
      post '/custom_maps', params: body

      expect(JSON.parse(response.body)['name']).to eq(body[:name])
    end
  end
end
