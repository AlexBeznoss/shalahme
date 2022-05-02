# frozen_string_literal: true

class User < ApplicationRecord
  enum role: {
    default: 0,
    admin: 10
  }
end
