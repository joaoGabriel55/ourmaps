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
      get "/custom_maps/#{custom_map.id}"

      expect(response.status).to eq(200)
    end

    it 'returns custom map' do
      get "/custom_maps/#{custom_map.id}"

      response_body = JSON.parse(response.body)

      expect(response_body).to include({
        'id' => String,
        'name' => custom_map.name,
        'center' => [ custom_map.lat_center, custom_map.lng_center ],
        'description' => custom_map.description
      })
      expect(response_body['content']).to eq(custom_map.content)
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
      center: [ 51.5074, -0.1278 ],
      description: 'New Custom Map Description',
      visibility: 'public'
    } }

    it 'returns 201 created status' do
      post '/custom_maps', params: body, as: :json

      expect(response.status).to eq(201)
    end

    it 'returns created custom map' do
      post '/custom_maps', params: body, as: :json

      expect(JSON.parse(response.body)['name']).to eq(body[:name])
    end

    context 'when a geojson content is provided' do
      let(:body) { {
        name: 'New Custom Map',
        owner_id: owner.id,
        description: 'New Custom Map Description',
        visibility: 'public',
        center: [ 51.5074, -0.1278 ],
        content: {
          type: "Feature",
          geometry: {
            type: "Point",
            coordinates: [ 125.6, 10.1 ]
          },
          properties: {
            name: "Dinagat Islands"
          }
        }
      } }

      it 'returns 201 created status' do
        post '/custom_maps', params: body, as: :json

        expect(response.status).to eq(201)
      end

      it 'returns created custom map content' do
        post '/custom_maps', params: body, as: :json

        expect(JSON.parse(response.body)['content']).to eq({
          "geometry"=>{
            "coordinates"=>[ 125.6, 10.1 ], "type"=>"Point" },
            "properties"=>{ "name"=>"Dinagat Islands" },
            "type"=>"Feature"
          })
      end

      it 'changes the number of custom maps on database' do
        expect do
          post '/custom_maps', params: body, as: :json
        end.to change { CustomMapRepository.count }.by(1)
      end
    end
  end

  describe 'update custom map' do
    let!(:owner) { FactoryBot.create(:user_repository, name: 'John', password: '123456') }
    let!(:custom_map) { FactoryBot.create(:custom_map_repository, owner:) }
    let(:body) { {
      name: 'Updated Custom Map',
      center: [ 51.5074, -0.1278 ],
      description: 'Updated Custom Map Description',
      visibility: 'public'
    } }

    it 'returns 200 ok status' do
      patch "/custom_maps/#{custom_map.id}", params: body, as: :json

      expect(response.status).to eq(200)
    end

    it 'returns updated custom map' do
      patch "/custom_maps/#{custom_map.id}", params: body, as: :json

      expect(JSON.parse(response.body)['name']).to eq(body[:name])
    end

    context 'when custom map not found' do
      it 'returns 404 not found status' do
        patch '/custom_maps/abc212', params: body, as: :json

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'delete custom map' do
    let!(:owner) { FactoryBot.create(:user_repository, name: 'John', password: '123456') }
    let!(:custom_map) { FactoryBot.create(:custom_map_repository, owner:) }

    it 'returns 204 no content status' do
      delete "/custom_maps/#{custom_map.id}"

      expect(response.status).to eq(204)
    end

    context 'when custom map not found' do
      it 'returns 404 not found status' do
        delete '/custom_maps/abc212'

        expect(response.status).to eq(404)
      end
    end
  end
end
