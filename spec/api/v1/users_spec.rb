# frozen_string_literal: true

require 'rails_helper'

describe Bpe::V1::Users do
  context 'with logged in user' do
    let(:user) { create :user }
    before :each do
      login_as(user, scope: :user)
    end
    context 'GET /api/v1/users' do
      it 'should return current user' do
        get '/api/v1/users'
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['user']['id'])
          .to eq(user.id)
      end
    end
  end
end
