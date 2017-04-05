# frozen_string_literal: true

require 'rails_helper'

describe Bpe::V1::States do
  let!(:designed) { create :state, name: 'designed' }
  let!(:assembled) { create :state, name: 'assembled', from_state: designed }
  let!(:painted) { create :state, name: 'painted', from_state: assembled }
  let!(:tested) { create :state, name: 'tested', from_state: painted }
  let(:user) { create :user }

  context 'with logged in user' do
    before :each do
      login_as(user, scope: :user)
    end

    context 'GET /api/v1/states' do
      it 'should return states' do
        get '/api/v1/states'
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['states'].count).to eq(4)
        expect(JSON.parse(response.body)['states'])
          .to eq(
            [{ 'id' => designed.id, 'name' => designed.name },
             { 'id' => assembled.id, 'name' => assembled.name,
               'from_state' => { 'id' => designed.id, 'name' => designed.name } },
             { 'id' => painted.id, 'name' => painted.name,
               'from_state' => { 'id' => assembled.id, 'name' => assembled.name } },
             { 'id' => tested.id, 'name' => tested.name,
               'from_state' => { 'id' => painted.id, 'name' => painted.name } }]
          )
      end
    end

    context 'POST /api/v1/states' do
      let(:state_params) do
        {
          name: 'released',
          from_state_id: tested.id
        }
      end

      context 'admin user' do
        let(:user) { create :admin }

        it 'should create a new state' do
          expect do
            post '/api/v1/states', params: state_params
          end.to change { State.count }.by(1)

          expect(JSON.parse(response.body)['state']['name']).to eq(state_params[:name])
        end
      end

      context 'regular user' do
        it 'should create a new state' do
          expect do
            post '/api/v1/states', params: state_params
          end.not_to change { State.count }

          expect(JSON.parse(response.body)['errors']).to include('not allowed')
        end
      end
    end

    context 'GET /api/v1/states/:id' do
      it 'should read state details' do
        get "/api/v1/states/#{designed.id}"
        expect(JSON.parse(response.body)['state'])
          .to eq(
            'id' => designed.id,
            'name' => designed.name
          )
      end

      it 'should handle active record not found error ' do
        get '/api/v1/states/923'
        expect(JSON.parse(response.body)).to eq('error' => 'Record not found!')
      end
    end

    context 'PUT /api/v1/states/:id' do
      let(:designed_params) { { name: 'Planned' } }
      context 'admin user' do
        let(:user) { create :admin }

        it 'should update state' do
          put "/api/v1/states/#{designed.id}", params: designed_params
          expect(JSON.parse(response.body)['state']['name']).to eq(designed_params[:name])
        end

        it 'validate handle not existing from state' do
          put "/api/v1/states/#{designed.id}", params: { from_state_id: 212_323 }
          expect(JSON.parse(response.body)['errors']).to eq('from_state' => ['Previous state not exists!'])
        end
      end

      context 'regular user' do
        it 'should not update state' do
          put "/api/v1/states/#{designed.id}", params: designed_params
          expect(JSON.parse(response.body)['errors']).to include('not allowed')
        end
      end
    end

    context 'DELETE /api/v1/states/:id' do
      context 'admin user' do
        let(:user) { create :admin }
        it 'should delete state' do
          expect do
            delete "/api/v1/states/#{tested.id}"
          end.to change { State.count }.by(-1)
          expect(JSON.parse(response.body)['states'].count).to eq(3)
        end

        it 'should delete state from the middle of the chain' do
          expect do
            delete "/api/v1/states/#{assembled.id}"
          end.to change { State.count }.by(-1)
          expect(JSON.parse(response.body)['states'].count).to eq(3)
          expect(painted.reload.from_state_id).to eq(designed.id)
        end
      end

      context 'regular user' do
        it 'should delete state' do
          expect do
            delete "/api/v1/states/#{tested.id}"
          end.not_to change { State.count }
          expect(JSON.parse(response.body)['errors']).to include('not allowed')
        end
      end
    end

    context 'PUT /api/v1/states/:id/up' do
      let(:user) { create :admin }

      it 'should move state up one position when no grandparent state exists' do
        put "/api/v1/states/#{assembled.id}/up"
        expect(response.status).to eq(200)

        expect(assembled.reload.from_state_id).to eq(nil)
        expect(designed.reload.from_state_id).to eq(assembled.id)
        expect(painted.reload.from_state_id).to eq(designed.id)
        expect(tested.reload.from_state_id).to eq(painted.id)
      end

      it 'should move state up one position' do
        put "/api/v1/states/#{painted.id}/up"
        expect(response.status).to eq(200)

        expect(designed.reload.from_state_id).to eq(nil)
        expect(painted.reload.from_state_id).to eq(designed.id)
        expect(assembled.reload.from_state_id).to eq(painted.id)
        expect(tested.reload.from_state_id).to eq(assembled.id)
      end

      it 'should move state up one position when no child state exist' do
        put "/api/v1/states/#{tested.id}/up"
        expect(response.status).to eq(200)

        expect(designed.reload.from_state_id).to eq(nil)
        expect(assembled.reload.from_state_id).to eq(designed.id)
        expect(tested.reload.from_state_id).to eq(assembled.id)
        expect(painted.reload.from_state_id).to eq(tested.id)
      end
    end

    context 'PUT /api/v1/states/:id/down' do
      let(:user) { create :admin }

      it 'should move state up one position when no grandparent state exists' do
        put "/api/v1/states/#{assembled.id}/down"
        expect(response.status).to eq(200)

        expect(designed.reload.from_state_id).to eq(nil)
        expect(painted.reload.from_state_id).to eq(designed.id)
        expect(tested.reload.from_state_id).to eq(assembled.id)
        expect(assembled.reload.from_state_id).to eq(painted.id)
      end

      it 'should move state up one position' do
        put "/api/v1/states/#{painted.id}/down"
        expect(response.status).to eq(200)

        expect(designed.reload.from_state_id).to eq(nil)
        expect(assembled.reload.from_state_id).to eq(designed.id)
        expect(tested.reload.from_state_id).to eq(assembled.id)
        expect(painted.reload.from_state_id).to eq(tested.id)
      end

      it 'should move state up one position when no child state exist' do
        put "/api/v1/states/#{tested.id}/down"
        expect(response.status).to eq(200)

        expect(designed.reload.from_state_id).to eq(nil)
        expect(assembled.reload.from_state_id).to eq(designed.id)
        expect(painted.reload.from_state_id).to eq(assembled.id)
        expect(tested.reload.from_state_id).to eq(painted.id)
      end
    end
  end

  context 'without logged in user' do
    context 'GET /api/v1/states' do
      it 'should return states' do
        get '/api/v1/states'
        expect(response.status).to eq(401)
        expect(JSON.parse(response.body)['error']).to eq('401 Unauthorized')
      end
    end
  end
end
