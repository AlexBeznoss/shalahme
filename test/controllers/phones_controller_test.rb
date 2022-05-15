# frozen_string_literal: true

require 'test_helper'
require 'test_helpers/authentication'

module PhonesControllerTest
  class IndexTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :get, '/phones'
      )
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

    test 'not renders phones of other users' do
      user = users(:github)
      other_user = users(:google)
      name = 'fake name'
      other_user.user_phone_numbers.create!(name:, area_code: '312')

      sign_in(user)
      get phones_path

      assert_response :success
      assert_select 'h3', count: 0, text: name
    end

    test 'not renders discarded phones' do
      user = users(:google)
      name = 'Fake name'
      user.user_phone_numbers.create!(
        name:,
        area_code: '312',
        discarded_at: Time.current
      )

      sign_in(user)
      get phones_path

      assert_response :success
      assert_select 'h3', count: 0, text: name
    end
  end

  class NewTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :get, '/phones/new'
      )
    end
  end

  class CreateTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :post, '/phones'
      )
    end

    test 'creates phone number' do
      user = users(:google)
      params = {
        user_phone_number: {
          name: 'Fake name',
          area_code: '312'
        }
      }

      sign_in(user)
      assert_changes -> { user.reload.user_phone_numbers.count } do
        post phones_path, params:
      end
      assert_equal params[:user_phone_number], UserPhoneNumber.last.attributes.symbolize_keys.slice(:name, :area_code)
      assert_redirected_to phones_path
    end
  end

  class EditTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :get, '/phones/1/edit'
      )
    end
  end

  class UpdateTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :put, '/phones/1'
      )
    end

    test 'updates phone number' do
      user = users(:google)
      number = user.user_phone_numbers.create!(name: 'Fake name', area_code: '312')
      params = {
        user_phone_number: {
          name: 'New name'
        }
      }

      sign_in(user)
      assert_changes -> { number.reload.name }, from: 'Fake name', to: 'New name' do
        put phone_path(number), params:
      end

      assert_redirected_to phones_path
    end
  end

  class DestroyTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'requires authentication' do
      assert_requires_authentication_for(
        :delete, '/phones/1'
      )
    end

    test 'discards phone number' do
      time = Time.current
      user = users(:google)
      number = user.user_phone_numbers.create!(name: 'Fake name', area_code: '312')

      sign_in(user)
      travel_to(time) do
        assert_changes -> { number.reload.discarded_at.to_i }, from: 0, to: time.to_i do
          delete phone_path(number)
        end

        assert_redirected_to phones_path
      end
    end
  end
end
