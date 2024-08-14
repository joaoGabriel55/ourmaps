# frozen_string_literal: true

require 'spec_helper'
require './app/usecases/users/create'

RSpec.describe '/users' do
  context 'get all users' do
    let!(:users) do
      UsersService.new(repositories:).create(params:)
    end
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
  end

  context 'create new user' do
    it { expect { post '/users' }.not_to raise_error }

    it 'returns 201 created status' do
      body = { name: 'John', password: '123456' }.to_json

      post '/users', body

      expect(last_response.status).to eq(201)
    end

    it 'returns created user' do
      body = { name: 'John', password: '123456' }.to_json

      post '/users', body

      expect(JSON.parse(last_response.body)['data']).to include({
        'id' => String,
        'name' => 'John',
        'createdAt' => String,
        'updatedAt' => nil
      })
    end
  end
end
