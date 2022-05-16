# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helpers/authentication'

module Phones
  class DeletesTest < ApplicationSystemTestCase
    include Authentication

    test 'updates phone number' do
      user = users(:google)
      user.phone_numbers.create!(name: 'Cool phone number', area_code: '216')

      sign_in user, :visit
      visit phones_path

      assert_selector 'h3', text: 'Cool phone number'

      accept_prompt do
        find('.remove').click
      end

      assert_selector 'h3', text: 'No phone numbers yet'
    end
  end
end
