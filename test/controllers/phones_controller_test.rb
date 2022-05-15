require 'test_helper'
require 'test_helpers/authentication'

module PhonesControllerTest
  class IndexTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'redirect to root when not authenticated' do
      get phones_path

      assert_redirected_to root_path
      assert_equal I18n.t('login_warning'), flash[:warning]
    end

    test 'renders user phones' do
      user = users(:google)
      name = 'Fake name'
      user.user_phone_numbers.create!(name:, area_code: '312')

      sign_in(user)
      get phones_path

      assert_response :success
      assert_select 'h3', name
    end
  end

  class NewTest < ActionDispatch::IntegrationTest
  end

  class CreateTest < ActionDispatch::IntegrationTest
  end

  class EditTest < ActionDispatch::IntegrationTest
  end

  class UpdateTest < ActionDispatch::IntegrationTest
  end

  class DestroyTest < ActionDispatch::IntegrationTest
  end
end
