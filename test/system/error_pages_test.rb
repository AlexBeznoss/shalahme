# frozen_string_literal: true

require 'application_system_test_case'

class ErrorPagesTest < ApplicationSystemTestCase
  test 'renders 404' do
    visit '/'

    visit '/bad-url'

    assert_response 404
    assert_text 'Not found'

    click_on 'Go back'

    assert_redirected_to '/'
  end
end
