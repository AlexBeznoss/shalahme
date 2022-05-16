# frozen_string_literal: true

class User < ApplicationRecord
  has_many :phone_numbers,
           dependent: :restrict_with_exception,
           class_name: 'UserPhoneNumber'

  enum role: {
    default: 0,
    admin: 10
  }
end
