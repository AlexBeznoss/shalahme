# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helpers/authentication'

module Phones
  class CreatesTest < ApplicationSystemTestCase
    include Authentication

    test 'creates new phone number' do # rubocop:disable Minitest/MultipleAssertions
      user = users(:google)

      sign_in user, :visit
      visit phones_path

      assert_selector 'h3', text: 'No phone numbers yet'

      click_on 'New phone number'
      fill_in 'Name', with: 'Cool name'
      fill_in 'Area code', with: '216'
      click_on 'Create'

      assert_selector(
        '.flashes .success div.text_wrapper',
        text: 'Phone created! It will be ready for usage soon.'
      )
      assert_selector 'h3', count: 0, text: 'No phone numbers yet'
      assert_selector 'h3', text: 'Cool name'
    end

    test 'show errors' do
      user = users(:google)

      sign_in user, :visit
      visit phones_path

      click_on 'New phone number'
      fill_in 'Name', with: 'Cool name'
      fill_in 'Area code', with: '21612312'
      click_on 'Create'

      assert_selector 'li', text: 'Area code is the wrong length (should be 3 characters)'
    end
  end
end
