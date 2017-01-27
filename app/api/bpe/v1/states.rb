# frozen_string_literal: true
module Bpe
  module V1
    class States < Grape::API
      resource :states do
        desc 'Return all States'
        get do
          states = State.all

          { states: states.render(:index) }
        end

        desc 'Create new state'
        params do
          requires :name, type: String, desc: 'State name'
          optional :from_id, type: Integer, desc: 'From which state a transition to this state is allowed'
        end
        post do
          state = State.create!(params)

          { state: state.render(:detail) }
        end

        desc 'Read state'
        route_param :id do
          get do
            state = State.find(params[:id])

            { state: state.render(:detail) }
          end
        end

        desc 'Update state'
        route_param :id do
          params do
            optional :name, type: String, desc: 'State name'
            optional :from_id, type: Integer, desc: 'From which state a transition to this state is allowed'
          end
          put do
            state = State.find(params[:id])
            state.update!(params)

            { state: state.render(:detail) }
          end
        end

        desc 'Delete state'
        route_param :id do
          delete do
            state = State.find(params[:id])
            state.destroy!

            { result: 'State deleted' }.to_json
          end
        end
      end
    end
  end
end
