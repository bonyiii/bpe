# frozen_string_literal: true
class Role < ApplicationRecord
  has_many :roles_users
  has_many :users, through: :roles_users

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
