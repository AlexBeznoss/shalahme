# frozen_string_literal: true

class RecipientPhoneNumber < ApplicationRecord
  has_many :dialogs, dependent: :destroy

  validates :number, presence: true, uniqueness: true
end
