# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    uid { Faker::Omniauth.google[:uid] }
    provider { 'google_oauth2' }
    name { Faker::Omniauth.google.dig(:info, :name) }
    email { Faker::Omniauth.google.dig(:info, :email) }
    logo_url { Faker::Omniauth.google.dig(:info, :image) }

    trait :github do
      provider { 'github' }
      uid { Faker::Omniauth.github[:uid] }
      name { Faker::Omniauth.github.dig(:info, :name) }
      email { Faker::Omniauth.github.dig(:info, :email) }
      logo_url { Faker::Omniauth.github.dig(:info, :image) }
    end
  end
end
