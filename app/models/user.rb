# frozen_string_literal: true
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable

  has_many :roles_users
  has_many :roles, through: :roles_users

  validates :first_name, presence: true
  validates :last_name, presence: true

  json(:index,
       only: %i(id email first_name last_name),
       methods: %i(is_admin))

  def role?(role_name)
    roles.where(name: role_name).exists?
  end

  def admin?
    role?('admin')
  end
  alias is_admin admin?
end
