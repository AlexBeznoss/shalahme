# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies

  def index?
    user.admin?
  end

  def edit?
    user.admin? && (user.id != record.id)
  end

  def update?
    edit?
  end
end
