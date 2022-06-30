# frozen_string_literal: true

FactoryBot.define do
  factory :dialog do
    association :user_phone_number
    association :recipient_phone_number
  end
end
