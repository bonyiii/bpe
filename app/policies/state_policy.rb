# frozen_string_literal: true

class StatePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    return true if admin_user?
    false
  end

  def update?
    return true if admin_user?
    false
  end

  def destroy?
    return true if admin_user?
    false
  end

  private

  def admin_user?
    user.role?('admin')
  end
end
