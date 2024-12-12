# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'get all users' do
    before do
      FactoryBot.create(:user_repository, name: 'John', password: '123456')
    end

    let(:params) { { name: 'John', password: '123456' } }

    it { expect { get '/users' }.not_to raise_error }

    it 'returns 200 ok status' do
      get '/users'

      expect(response.status).to eq(200)
    end

    it 'returns all users' do
      get '/users'

      expect(JSON.parse(response.body)).to include({
        'id' => String,
        'name' => params[:name],
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    it 'returns users count' do
      get '/users'

      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  context 'get all users with pagination' do
    before do
      FactoryBot.create(:user_repository, name: 'John', password: '123456')
    end

    let(:params) { { name: 'John', password: '123456' } }

    it { expect { get '/users?page=2&per_page=1' }.not_to raise_error }

    it 'returns 200 ok status' do
      get '/users?page=1&per_page=1'

      expect(response.status).to eq(200)
    end

    it 'returns all users' do
      get '/users?page=1&per_page=1'

      expect(JSON.parse(response.body)).to include({
        'id' => String,
        'name' => params[:name],
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    it 'returns users count' do
      get '/users?page=1&per_page=1'

      expect(JSON.parse(response.body).size).to eq(1)
    end

    context 'when page do not have users' do
      it 'returns users count as 0' do
        get '/users?page=2&per_page=1'

        expect(JSON.parse(response.body).size).to eq(0)
      end
    end
  end

  context 'get user by id' do
    let!(:user_id) { FactoryBot.create(:user_repository, name: 'John', password: '123456').id }
    let(:params) { { name: 'John', password: '123456' } }

    it { expect { get "/users/#{user_id}" }.not_to raise_error }

    it 'returns 200 ok status' do
      get "/users/#{user_id}"

      expect(response.status).to eq(200)
    end

    it 'returns user' do
      get "/users/#{user_id}"

      expect(JSON.parse(response.body)).to include({
        'id' => String,
        'name' => params[:name],
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    context 'when user not found' do
      it 'returns 404 not found status' do
        get '/users/abc212'

        expect(response.status).to eq(404)
      end
    end
  end

  context 'create new user' do
    let(:body) { { name: 'John', password: '123456' } }

    it 'returns 201 created status' do
      post '/users', params: body

      expect(response.status).to eq(201)
    end

    it 'returns created user' do
      post '/users', params: body

      expect(JSON.parse(response.body)['name']).to eq(body[:name])
    end
  end

  context 'update user' do
    let!(:user_id) { FactoryBot.create(:user_repository, name: 'John', password: '123456').id }
    let(:body) { { name: 'John updated', password: '123459' } }

    it 'returns 204 ok status' do
      patch "/users/#{user_id}", params: body

      expect(response.status).to eq(204)
      expect(UserRepository.find(user_id).name).to eq(body[:name])
    end

    context 'when user not found' do
      let(:body) { { id: 'abc212', name: 'John updated', password: '123459' }.to_json }

      it 'returns 404 not found status' do
        patch '/users/abc212', params: body

        expect(response.status).to eq(404)
      end
    end
  end

  context 'delete user' do
    let!(:user_id) { FactoryBot.create(:user_repository, name: 'John', password: '123456').id }

    it 'returns 204 no content status' do
      delete "/users/#{user_id}"

      expect(response.status).to eq(204)
    end

    it 'returns 404 not found status' do
      delete '/users/abc212'

      expect(response.status).to eq(404)
    end
  end
end