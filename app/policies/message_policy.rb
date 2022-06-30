# frozen_string_literal: true

class MessagePolicy < ApplicationPolicy
  def read?
    record.dialog.user_phone_number.user_id == user.id
  end
end
