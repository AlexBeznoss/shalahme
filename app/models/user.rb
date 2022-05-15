# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_phone_numbers, dependent: :restrict_with_exception

  enum role: {
    default: 0,
    admin: 10
  }
end
