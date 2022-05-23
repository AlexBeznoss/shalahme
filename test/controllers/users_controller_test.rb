# frozen_string_literal: true

require 'test_helper'
require 'test_helpers/authentication'

module UsersControllerTest
  class IndexTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(:get, '/users')
    end

    test 'requires to be admin' do
      user = users(:google)

      sign_in(user)
      get users_path

      assert_redirected_to root_path
    end

    test 'renders users' do
      admin = users(:google)
      admin.update(role: :admin)

      sign_in(admin)
      get users_path

      assert_response :success
      assert_select 'p', users[0].email
      assert_select 'p', users[1].email
    end
  end

  class EditTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(:get, '/users/1/edit')
    end

    test 'requires to be admin' do
      user = users(:google)

      sign_in(user)
      get edit_user_path(user)

      assert_redirected_to root_path
    end
  end

  class UpdateTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(:put, '/users/1')
    end

    test 'requires to be admin' do
      user = users(:github)

      sign_in(user)
      put user_path(user), params: { user: { role: 'admin' } }

      assert_redirected_to root_path
    end

    test 'allows admin update user role' do
      admin = users(:google)
      admin.update(role: :admin)
      user = users(:github)

      sign_in(admin)
      assert_changes -> { user.reload.role }, from: 'default', to: 'admin' do
        put user_path(user), params: { user: { role: 'admin' } }
      end

      assert_redirected_to users_path
    end
  end
end
