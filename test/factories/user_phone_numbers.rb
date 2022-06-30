# frozen_string_literal: true

FactoryBot.define do
  factory :user_phone_number do
    sequence(:name) { |n| Faker::Cannabis.cannabinoid + " - #{n}" }
    area_code { Faker::PhoneNumber.area_code }
    association :user

    trait :ready do
      status { :ready }
      sid { Faker::Internet.uuid }
      number { Faker::PhoneNumber.cell_phone_in_e164 }
    end
  end
end