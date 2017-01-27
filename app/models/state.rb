class State < ApplicationRecord
  has_one :next, class_name: 'State', foreign_key: 'from_id'
  belongs_to :from, class_name: 'State'

  json(:index, only: %i(id name))

  def self.initial
    where(from: nil).first
  end
end
