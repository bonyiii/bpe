# frozen_string_literal: true
require 'rails_helper'

describe Bpe::V1::Vehicles do
  let!(:designed_state) { create :state, name: 'designed' }
  let!(:painted_state) { create :state, name: 'painted', from: designed_state }
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
             'has_next_state' => jaguar.next_state?,
             'state' => { 'id' => designed_state.id, 'name' => designed_state.name } },
           { 'id' => bmw.id,
             'has_next_state' => bmw.next_state?,
             'name' => bmw.name,
             'state' => { 'id' => designed_state.id, 'name' => designed_state.name } },
           { 'id' => ford.id,
             'has_next_state' => ford.next_state?,
             'name' => ford.name,
             'state' => { 'id' => designed_state.id, 'name' => designed_state.name } }]
        )
    end
  end

  context 'POST /api/v1/vehicles' do
    let(:vehicle_params) do
      {
        name: 'Toyota'
      }
    end

    it 'should create a new vehicle' do
      expect do
        post '/api/v1/vehicles', params: vehicle_params
      end.to change { Vehicle.count }.by(1)

      expect(JSON.parse(response.body)['vehicle']['name']).to eq(vehicle_params[:name])
    end

    it 'should respond with error if params invalid' do
      expect do
        post '/api/v1/vehicles', params: {}
      end.not_to change { Vehicle.count }
      expect(JSON.parse(response.body)).to eq('error' => 'name is missing')
    end
  end

  context 'GET /api/v1/vehicles/:id' do
    it 'should read vehicle details' do
      put "/api/v1/vehicles/#{jaguar.id}"
      expect(JSON.parse(response.body)['vehicle'])
        .to eq(
          'id' => jaguar.id,
          'name' => jaguar.name,
          'has_next_state' => jaguar.next_state?,
          'state' => { 'id' => designed_state.id, 'name' => designed_state.name }
        )
    end
  end

  context 'PUT /api/v1/vehicles/:id' do
    let(:jaguar_params) { { name: 'Kia' } }
    it 'should update vehicle' do
      put "/api/v1/vehicles/#{jaguar.id}", params: jaguar_params
      expect(JSON.parse(response.body)['vehicle']['name']).to eq(jaguar_params[:name])
    end
  end

  context 'DELETE /api/v1/vehicles/:id' do
    it 'should delete vehicle' do
      delete "/api/v1/vehicles/#{jaguar.id}"
      expect(JSON.parse(response.body)).to eq('result' => 'Vehicle deleted')
    end
  end

  context 'PUT /api/v1/vehicles/:id/next_designed_state' do
    let(:jaguar_params) { { name: 'Kia' } }
    it 'should update vehicle' do
      put "/api/v1/vehicles/#{jaguar.id}/next_state", params: jaguar_params
      expect(JSON.parse(response.body)['vehicle']['state']['name']).to eq(painted_state.name)
      expect(JSON.parse(response.body)['vehicle']['has_next_state']).to be(false)
    end
  end
end
