# frozen_string_literal: true
class State < ApplicationRecord
  has_one :next_state, class_name: 'State', foreign_key: 'from_state_id'
  belongs_to :from_state, class_name: 'State'
  has_many :vehicles, dependent: :destroy

  validates :from_state,
            presence: { allow_blank: true },
            uniqueness: { allow_blank: true }
  validates :name, presence: true
  validate :validate_from_state_id

  before_destroy :check_dependent_state

  json(:index,
       only: %i(id name),
       include: { from_state: { only: [:id, :name] } })

  json(:detail,
       only: %i(id name),
       include: { from_state: { only: [:id, :name] } })

  def self.initial
    where(from_state_id: nil).first
  end

  def self.list
    find_by_sql(rcte)
  end

  def self.rcte
    <<-SQL
        with recursive next_state AS (
          select * from states where states.from_state_id IS NULL
          union all
          select s.* from states as s join next_state AS ns on (s.from_state_id = ns.id)
        )
        select * from next_state
      SQL
  end

  private

  def validate_from_state_id
    return if from_state_id.blank?
    return if State.where(id: from_state_id).exists?
    errors.add(:from_state, 'Previous state not exists!')
  end

  def check_dependent_state
    return true if next_state.blank?
    errors.add(:next_state, 'Cannot delete, a dependent state exists!')
    throw(:abort) if errors.present?
  end
end
