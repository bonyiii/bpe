# frozen_string_literal: true
require 'rails_helper'

describe Bpe::V1::Vehicles do
  let!(:state) { create :state, name: 'designed' }
  let!(:jaguar) { create :vehicle, name: 'Jaguar' }
  let!(:bmw) { create :vehicle, name: 'Bmw' }
  let!(:ford) { create :vehicle, name: 'Ford' }

  context 'GET /api/v1/vehicles' do
    # before :each do
    #  login_as(user, scope: :user)
    # end

    it 'should return vehicles' do
      get '/api/v1/vehicles'
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['vehicles'].count).to eq(3)
      expect(JSON.parse(response.body)['vehicles'])
        .to eq(
          [{ 'id' => jaguar.id,
             'name' => jaguar.name,
             'state' => { 'id' => state.id, 'name' => state.name } },
           { 'id' => bmw.id,
             'name' => bmw.name,
             'state' => { 'id' => state.id, 'name' => state.name } },
           { 'id' => ford.id,
             'name' => ford.name,
             'state' => { 'id' => state.id, 'name' => state.name } }]
        )
    end
  end
end
