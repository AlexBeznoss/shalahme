# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helpers/authentication'

module Phones
  class EditsTest < ApplicationSystemTestCase
    include Authentication

    test 'updates phone number' do
      user = users(:google)
      user.user_phone_numbers.create!(name: 'Cool phone number', area_code: '216')

      sign_in user, :visit
      visit phones_path

      assert_selector 'h3', text: 'Cool phone number'

      click_on 'Edit'
      fill_in 'Name', with: 'Another name'
      click_on 'Update'

      assert_selector(
        '.flashes .info div.text_wrapper',
        text: 'Phone successfully updated!'
      )
      assert_selector 'h3', text: 'Another name'
    end

    test 'show errors' do
      user = users(:google)
      phone = user.user_phone_numbers.create!(name: 'Cool phone number', area_code: '216')
      user.user_phone_numbers.create!(name: 'Another phone number', area_code: '216')

      sign_in user, :visit
      visit phones_path

      within(:css, "#user_phone_number_#{phone.id}") do
        click_on 'Edit'
      end
      fill_in 'Name', with: 'Another phone number'
      click_on 'Update'

      assert_selector 'li', text: 'Name has already been taken'
    end
  end
end
