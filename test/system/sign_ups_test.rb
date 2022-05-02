require 'application_system_test_case'

class SignUpsTest < ApplicationSystemTestCase
  test 'creates user by google' do
    info = Faker::Omniauth.google
    OmniAuth.config.add_mock(:google_oauth2, info)

    visit root_path

    assert_selector 'a', text: 'Sign in with Google'

    assert_changes -> { User.count } do
      click_on 'Sign in with Google'
    end

    assert_selector 'a', text: 'Dashboard'
    validate_last_user(
      provider: 'google_oauth2',
      uid: info[:uid],
      info: info.to_h[:info]
    )
  end

  test 'creates user by github' do
    info = Faker::Omniauth.github
    OmniAuth.config.add_mock(:github, info)

    visit root_path

    assert_selector 'a', text: 'Sign in with Github'

    assert_changes -> { User.count } do
      click_on 'Sign in with Github'
    end

    assert_selector 'a', text: 'Dashboard'
    validate_last_user(
      provider: 'github',
      uid: info[:uid],
      info: info.to_h[:info]
    )
  end

  private

  def validate_last_user(provider:, uid:, info:)
    user = User.last
    assert_equal provider, user.provider
    assert_equal uid, user.uid
    assert_equal info[:email], user.email
    assert_equal info[:name], user.name
    assert_equal info[:image], user.logo_url
  end
end
