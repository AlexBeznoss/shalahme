# frozen_string_literal: true

require 'test_helper'
require 'test_helpers/authentication'

module DialogsControllerTest
  class NewTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :get, '/phones/1/dialogs/new'
      )
    end
  end

  class CreateTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :post, '/phones/1/dialogs'
      )
    end
  end
end
