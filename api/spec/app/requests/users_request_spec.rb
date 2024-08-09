# frozen_string_literal: true

require 'spec_helper'

RSpec.describe '/users' do
  it { expect { get '/users' }.not_to raise_error }
  it { expect { post '/users' }.not_to raise_error }

  context 'create new user' do
    it 'returns 201 created status' do
      body = { name: 'John', password: '123456' }.to_json

      post '/users', body

      expect(last_response.status).to eq(201)
    end

    it 'returns created user' do
      body = { name: 'John', password: '123456' }.to_json

      post '/users', body

      expect(JSON.parse(last_response.body)['data']).to include({
        'id' => String, 'name' => 'John', 'createdAt' => String, 'updatedAt' => nil
      })
    end
  end
end
