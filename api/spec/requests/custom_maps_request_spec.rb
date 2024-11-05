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

    it 'returns the 2 custom maps' do
      get '/custom_maps?owner_id=' + owner.id

      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe 'get map by id' do
    let!(:owner) { FactoryBot.create(:user_repository, name: 'John', password: '123456') }
    let!(:custom_map) { FactoryBot.create(:custom_map_repository, owner:) }

    it 'returns 200 ok status' do
      get '/custom_maps/' + custom_map.id

      expect(response.status).to eq(200)
    end

    it 'returns custom map' do
      get '/custom_maps/' + custom_map.id

      expect(JSON.parse(response.body)).to include({
        'id' => String,
        'name' => custom_map.name,
        'description' => custom_map.description,
        'content' => custom_map.content
      })
    end

    context 'when custom map s not found' do
      it 'returns 404 not found status' do
        get '/custom_maps/abc212'

        expect(response.status).to eq(404)
      end
    end
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
