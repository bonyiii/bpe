# frozen_string_literal: true
class StatePolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    return true if admin_user?
  end

  def update?
    return true if admin_user?
  end

  def destroy?
    return true if admin_user?
  end

  private

  def admin_user?
    user.role?('admin')
  end
end
