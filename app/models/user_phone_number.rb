# frozen_string_literal: true

class UserPhoneNumber < ApplicationRecord
  include Discard::Model

  belongs_to :user

  enum status: {
    draft: 0,
    ready: 10,
    error: 20
  }

  validates :name, :area_code, presence: true
  validates :area_code, length: { is: 3 }, numericality: { only_integer: true }
  validates :name, uniqueness: { scope: :user_id, conditions: -> { kept } }
end
