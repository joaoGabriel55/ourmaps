# frozen_string_literal: true

require 'rails_helper'

RSpec.describe.skip 'Users' do
  context 'get all users' do
    before { UsersService.new(repository:).create(params:) }

    let(:repository) { repositories[:user_repository] }
    let(:params) { { name: 'John', password: '123456' } }

    it { expect { get '/users' }.not_to raise_error }

    it 'returns 200 ok status' do
      get '/users'

      expect(last_response.status).to eq(200)
    end

    it 'returns all users' do
      get '/users'

      expect(JSON.parse(last_response.body)['data'][0]).to include({
        'id' => String,
        'name' => params[:name],
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    it 'returns users count' do
      get '/users'

      expect(JSON.parse(last_response.body)['data'].size).to eq(1)
    end
  end

  context 'get all users with pagination' do
    before { UsersService.new(repository:).create(params:) }

    let(:repository) { repositories[:user_repository] }
    let(:params) { { name: 'John', password: '123456' } }

    it { expect { get '/users?page=2&per_page=1' }.not_to raise_error }

    it 'returns 200 ok status' do
      get '/users?page=1&per_page=1'

      expect(last_response.status).to eq(200)
    end

    it 'returns all users' do
      get '/users?page=1&per_page=1'

      expect(JSON.parse(last_response.body)['data'][0]).to include({
        'id' => String,
        'name' => params[:name],
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    it 'returns users count' do
      get '/users?page=1&per_page=1'

      expect(JSON.parse(last_response.body)['data'].size).to eq(1)
    end

    context 'when page do not have users' do
      it 'returns users count as 0' do
        get '/users?page=2&per_page=1'

        expect(JSON.parse(last_response.body)['data'].size).to eq(0)
      end
    end
  end

  context 'get user by id' do
    let!(:user_id) do
      user = UsersService.new(repository:).create(params:)

      user['id']
    end
    let(:repository) { repositories[:user_repository] }
    let(:params) { { name: 'John', password: '123456' } }

    it { expect { get "/users/#{user_id}" }.not_to raise_error }

    it 'returns 200 ok status' do
      get "/users/#{user_id}"

      expect(last_response.status).to eq(200)
    end

    it 'returns user' do
      get "/users/#{user_id}"

      expect(JSON.parse(last_response.body)['data']).to include({
        'id' => String,
        'name' => params[:name],
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    context 'when user not found' do
      it 'returns 404 not found status' do
        get '/users/abc212'

        expect(last_response.status).to eq(404)
      end
    end
  end

  context 'create new user' do
    let(:body)  { { name: 'John', password: '123456' }.to_json }

    it { expect { post '/users' }.not_to raise_error }

    it 'returns 201 created status' do
      post '/users', body

      expect(last_response.status).to eq(201)
    end

    it 'returns created user' do
      post '/users', body

      expect(JSON.parse(last_response.body)['data']).to include({
        'id' => String,
        'name' => 'John',
        'createdAt' => String,
        'updatedAt' => nil
      })
    end
  end

  context 'update user' do
    let!(:user_id) do
      user = UsersService.new(repository:).create(params:)

      user['id']
    end
    let(:repository) { repositories[:user_repository] }
    let(:params) { { name: 'John', password: '123456' } }
    let(:body) { { id: user_id, name: 'John updated', password: '123459' }.to_json }

    it { expect { patch "/users/#{user_id}" }.not_to raise_error }

    it 'returns 200 ok status' do
      patch "/users/#{user_id}", body

      expect(last_response.status).to eq(200)
    end

    it 'returns updated user' do
      patch "/users/#{user_id}", body

      expect(JSON.parse(last_response.body)['data']).to include({
        'id' => String,
        'name' => 'John updated',
        'createdAt' => String,
        'updatedAt' => String
      })
    end

    context 'when user not found' do
      let(:body) { { id: 'abc212', name: 'John updated', password: '123459' }.to_json }

      it 'returns 404 not found status' do
        patch '/users/abc212', body

        expect(last_response.status).to eq(404)
      end
    end
  end

  context 'delete user' do
    let!(:user_id) do
      user = UsersService.new(repository:).create(params:)

      user['id']
    end
    let(:repository) { repositories[:user_repository] }
    let(:params) { { name: 'John', password: '123456' } }

    it { expect { delete "/users/#{user_id}" }.not_to raise_error }

    it 'returns 204 no content status' do
      delete "/users/#{user_id}"

      expect(last_response.status).to eq(204)
    end

    it 'returns 404 not found status' do
      get '/users/abc212'

      expect(last_response.status).to eq(404)
    end
  end
end
