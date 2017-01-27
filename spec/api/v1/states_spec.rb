# frozen_string_literal: true
require 'rails_helper'

describe Bpe::V1::States do
  let!(:designed) { create :state, name: 'designed' }
  let!(:assembled) { create :state, name: 'assembled', from: designed }
  let!(:painted) { create :state, name: 'painted', from: assembled }
  let!(:tested) { create :state, name: 'tested', from: painted }

  context 'GET /api/v1/states' do
    it 'should return states' do
      get '/api/v1/states'
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['states'].count).to eq(4)
      expect(JSON.parse(response.body)['states'])
        .to eq(
          [{ 'id' => designed.id, 'name' => designed.name },
           { 'id' => assembled.id, 'name' => assembled.name },
           { 'id' => painted.id, 'name' => painted.name },
           { 'id' => tested.id, 'name' => tested.name }]
        )
    end
  end

  context 'POST /api/v1/states' do
    let(:state_params) do
      {
        name: 'released'
      }
    end

    it 'should create a new state' do
      expect do
        post '/api/v1/states', params: state_params
      end.to change { State.count }.by(1)

      expect(JSON.parse(response.body)['state']['name']).to eq(state_params[:name])
    end
  end

  context 'GET /api/v1/states/:id' do
    it 'should read state details' do
      put "/api/v1/states/#{designed.id}"
      expect(JSON.parse(response.body)['state'])
        .to eq(
          'id' => designed.id,
          'name' => designed.name
        )
    end
  end

  context 'PUT /api/v1/states/:id' do
    let(:designed_params) { { name: 'Planned' } }
    it 'should update state' do
      put "/api/v1/states/#{designed.id}", params: designed_params
      expect(JSON.parse(response.body)['state']['name']).to eq(designed_params[:name])
    end
  end

  context 'DELETE /api/v1/states/:id' do
    it 'should delete state' do
      delete "/api/v1/states/#{tested.id}"
      expect(JSON.parse(response.body)).to eq('result' => 'State deleted')
    end
  end
end