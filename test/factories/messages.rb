# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }
    num_segments { 1 }
    kind { :sms }
    direction { :outbound }
    association :dialog

    trait :inbound do
      direction { :inbound }
    end

    trait :outbound do
      direction { :outbound }
    end

    trait :sms do
      kind { :sms }
    end

    trait :mms do
      kind { :mms }
      image_urls { [Faker::LoremFlickr.image] }
    end
  end
end
