class Vehicle < ApplicationRecord
  INITIAL_STATE = 'design'
  STATES = %w(design plan allowed other).freeze

  validates :name, presence: true
  validates :state, presence: true
  validate :valid_state_transition?

  before_create :init_state

  def valid_state_transition?

  end

  def init_state
    return if state.present?
    self.state = INITIAL_STATE
  end
end
