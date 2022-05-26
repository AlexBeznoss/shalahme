# frozen_string_literal: true

require 'application_system_test_case'

class ErrorPagesTest < ApplicationSystemTestCase
  setup do
    Rails.application.config.consider_all_requests_local = false
    Rails.application.config.action_dispatch.show_exceptions = true
  end

  teardown do
    Rails.application.config.consider_all_requests_local = true
    Rails.application.config.action_dispatch.show_exceptions = false
  end

  test 'renders 404' do
    visit '/'
    visit '/bad-url'

    assert_text '404 ERROR'
    assert_text 'Sorry, we couldn’t find the page you’re looking for'
    click_on 'Go back'

    assert_current_path '/'
  end

  test 'renders 500' do
    PagesController.any_instance.stubs(:home).raises(StandardError)

    visit '/'

    assert_text '500 ERROR'
    assert_text 'Something went wrong'
  end
end
