# frozen_string_literal: true
class State < ApplicationRecord
  has_one :next_state, class_name: 'State', foreign_key: 'from_state_id'
  belongs_to :from_state, class_name: 'State'

  validates :from_state, presence: { allow_blank: true }, uniqueness: true
  validates :name, presence: true
  validate :validate_from_state_id

  json(:index,
       only: %i(id name),
       include: { from_state: { only: [:id, :name] } })

  json(:detail,
       only: %i(id name),
       include: { from_state: { only: [:id, :name] } })

  def self.initial
    where(from_state_id: nil).first
  end

  private

  def validate_from_state_id
    return if from_state_id.blank?
    return if State.where(id: from_state_id).exists?
    errors.add(:from_state, 'Previous state not exists!')
  end
end
