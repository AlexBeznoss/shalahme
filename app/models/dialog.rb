# frozen_string_literal: true

class Dialog < ApplicationRecord
  belongs_to :user_phone_number
  belongs_to :recipient_phone_number
  has_many :messages, dependent: :destroy
end
