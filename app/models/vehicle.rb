class Vehicle < ApplicationRecord
  validates :name, presence: true
  validates :state, presence: true
  validate :valid_state_transition?

  before_create :init_state

  def valid_state_transition?

  end

  def init_state
    return if state.present?
    self.state = State.initial
  end
end
