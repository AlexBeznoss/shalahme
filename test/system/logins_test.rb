# frozen_string_literal: true

require 'application_system_test_case'

class LoginsTest < ApplicationSystemTestCase
  test 'login by google' do
    info = Faker::Omniauth.google
    User.create!(uid: info[:uid], provider: info[:provider])
    OmniAuth.config.add_mock(:google_oauth2, info)

    visit root_path

    assert_selector 'a', text: 'Sign in with Google'

    assert_no_changes -> { User.count } do
      click_on 'Sign in with Google'
    end

    assert_selector 'a', text: 'Dashboard'
  end

  test 'creates user by github' do
    info = Faker::Omniauth.github
    User.create!(uid: info[:uid], provider: info[:provider])
    OmniAuth.config.add_mock(:github, info)

    visit root_path

    assert_selector 'a', text: 'Sign in with Github'

    assert_no_changes -> { User.count } do
      click_on 'Sign in with Github'
    end

    assert_selector 'a', text: 'Dashboard'
  end
end
