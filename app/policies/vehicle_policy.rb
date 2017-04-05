# frozen_string_literal: true

class VehiclePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    return true if admin_user?
    false
  end

  def next_state?
    true
  end

  private

  def admin_user?
    user.role?('admin')
  end
end
