class Vehicle < ApplicationRecord
  belongs_to :state

  validates :name, presence: true
  validates :state, presence: true
  validate :valid_state_transition?

  before_validation :initial_state

  json(:index,
       only: %i(id name),
       include: { state: State.json(:index)})

  def next_state?
    state.next.present?
  end

  def next_state!
    if state.next.blank?
      errors.add(:state, 'No more state transition available')
      return false
    end

    self.state = state.next
    save!
  end

  private

  def valid_state_transition?
    return true unless state_id_changed?
    if state.from_id != state_id_was
      old_state = State.find(state_id_was)
      errors.add(:state, 'Invalid transition from #{old_state.name} to #{state.name}')
    end
  end

  def initial_state
    return if state.present?
    self.state = State.initial
  end
end
