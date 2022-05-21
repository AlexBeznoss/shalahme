# frozen_string_literal: true

FactoryBot.define do
  factory :recipient_phone_number do
    sequence(:number) do |n|
      "+1205#{n}541456".truncate(12)
    end
  end
end
