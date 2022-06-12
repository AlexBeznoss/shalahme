# frozen_string_literal: true

class UserPhoneNumber < ApplicationRecord
  include Discard::Model

  belongs_to :user
  has_many :dialogs, dependent: :destroy

  enum status: {
    draft: 0,
    ready: 10,
    error: 20
  }

  validates :name, :area_code, presence: true
  validates :area_code, length: { is: 3 }, numericality: { only_integer: true }
  validates :name, uniqueness: { scope: :user_id, conditions: -> { kept } }

  # TODO: REMOVE IT AFTER STATUS UPDATE IMPLEMENTED, PLZ
  # I'M BEGGING YOU!!!!!
  after_update if: proc { status_changed? } do
    Rails.cache.delete("ready_numbers_for_#{user.id}")
    Rails.cache.delete("#{user.id}_has_ready_number")
  end
end
