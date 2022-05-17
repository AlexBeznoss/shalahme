# frozen_string_literal: true

require 'application_system_test_case'
require 'test_helpers/authentication'

module Users
  class EditsTest < ApplicationSystemTestCase
    include Authentication

    test 'updates user' do
      user = users(:google)

      sign_in user, :visit
      visit users_path

      assert_selector 'p', text: 'default'

      edit_buttons = find_all "a", text: "Edit"
      edit_buttons.first.click

      select "admin"
      click_on 'Update'

      assert_selector(
        '.flashes .info div.text_wrapper',
        text: 'User successfully updated!'
      )
      assert_selector 'p', text: 'admin'
    end
  end
end
