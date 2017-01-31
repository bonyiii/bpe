# frozen_string_literal: true
module Bpe
  module V1
    class States < Grape::API
      resource :states do
        desc 'Return all States'
        get do
          states = State.all
          authorize :state, :index?

          { states: states.render(:index) }
        end

        desc 'Create new state'
        params do
          requires :name,
                   type: String,
                   desc: 'State name'
          optional :from_state_id,
                   type: Integer,
                   desc: 'From which state a transition to this state is allowed'
        end
        post do
          authorize :state, :create?
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
            optional :name,
                     type: String,
                     desc: 'State name'
            optional :from_state_id,
                     type: Integer,
                     desc: 'From which state a transition to this state is allowed'
          end
          put do
            state = State.find(params[:id])
            authorize state, :update?
            state.update!(params)

            { state: state.render(:detail) }
          end
        end

        desc 'Delete state'
        route_param :id do
          delete do
            state = State.find(params[:id])
            authorize state, :destroy?
            state.destroy!

            { result: 'State deleted' }.to_json
          end
        end

        desc 'Update state'
        route_param :id do
          params do
            optional :name,
                     type: String,
                     desc: 'State name'
            optional :from_state_id,
                     type: Integer,
                     desc: 'From which state a transition to this state is allowed'
          end
          put do
            state = State.find(params[:id])
            authorize state, :update?
            state.update!(params)

            { state: state.render(:detail) }
          end
        end


        route_param :id do
          desc 'Swap with place with previous state'
          put :up do
            state = State.find(params[:id])
            authorize state, :update?

            ActiveRecord::Base.transaction do
              parent_state = state.from_state
              if parent_state
                grandparent_state = parent_state.from_state
                child_state = state.next_state

                state.update(from_state: nil)
                child_state.update(from_state: nil) if child_state
                parent_state.update(from_state: nil)

                child_state.update(from_state: parent_state) if child_state
                parent_state.update(from_state: state)
                state.update(from_state: grandparent_state) if grandparent_state
              end
            end

            states = State.all
            { states: states.render(:index) }
          end

          desc 'Swap with place with next state'
          put :down do
            state = State.find(params[:id])
            authorize state, :update?

            ActiveRecord::Base.transaction do
              # tested
              child_state = state.next_state
              if child_state
                # assembled
                parent_state = state.from_state
                # nil
                grandchild_state = child_state.next_state

                # painted
                state.update(from_state: nil)
                child_state.update(from_state: nil)
                grandchild_state.update(from_state: nil) if grandchild_state

                grandchild_state.update(from_state: state) if grandchild_state
                state.update(from_state: child_state)
                child_state.update(from_state: parent_state)
              end
            end

            states = State.all
            { states: states.render(:index) }
          end
        end
      end
    end
  end
end
