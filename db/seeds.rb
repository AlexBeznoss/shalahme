# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
require 'progress_bar'

Faker::Config.locale = 'en-US'

bar = ProgressBar.new(4084)
user = User.create!(provider: 'google_oauth2', uid: '107441595726592436145')

phone1 = UserPhoneNumber.create!(
  name: 'Main number',
  number: Faker::PhoneNumber.cell_phone_in_e164,
  area_code: Faker::PhoneNumber.area_code,
  status: :ready,
  user:
)
bar.increment!
UserPhoneNumber.create!(
  name: 'Another number',
  number: Faker::PhoneNumber.cell_phone_in_e164,
  area_code: Faker::PhoneNumber.area_code,
  user:
)
bar.increment!
phone2 = UserPhoneNumber.create!(
  name: 'Secondary number',
  number: Faker::PhoneNumber.cell_phone_in_e164,
  area_code: Faker::PhoneNumber.area_code,
  status: :ready,
  user:
)
bar.increment!

[phone1, phone2].map do |user_phone_number|
  Thread.new do
    20.times.each do
      recipient_phone_number = RecipientPhoneNumber.create_or_find_by(number: Faker::PhoneNumber.cell_phone_in_e164)
      bar.increment!
      dialog = Dialog.create!(user_phone_number:, recipient_phone_number:)
      bar.increment!

      100.times.each do |i|
        Message.create!(
          content: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 8),
          status: :delivered,
          direction: i.even? ? :outbound : :inbound,
          kind: :sms,
          dialog:
        )
        bar.increment!
      end
    end
  end
end.each(&:join)
