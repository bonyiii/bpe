# frozen_string_literal: true
class State < ApplicationRecord
  has_one :next_state, class_name: 'State', foreign_key: 'from_state_id'
  belongs_to :from_state, class_name: 'State'

  json(:index, only: %i(id name))

  json(:detail, only: %i(id name))

  def self.initial
    where(from_state_id: nil).first
  end
end
