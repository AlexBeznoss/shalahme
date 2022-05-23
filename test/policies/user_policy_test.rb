# frozen_string_literal: true

require 'test_helper'

module UserPolicyTest
  class IndexTest < ActiveSupport::TestCase
    test 'returns false for NOT admin' do
      user = users(:github)

      policy = UserPolicy.new(user:)

      assert_not(policy.index?)
    end

    test 'returns true for admin' do
      user = users(:github)
      user.update(role: :admin)

      policy = UserPolicy.new(user:)

      assert_predicate(policy, :index?)
    end
  end

  class EditTest < ActiveSupport::TestCase
    test 'returns false for NOT admin' do
      user = users(:github)

      policy = UserPolicy.new(user:)

      assert_not(policy.edit?)
    end

    test 'returns false if admin edit himself' do
      admin = users(:github)
      admin.update(role: :admin)

      policy = UserPolicy.new(admin, user: admin)

      assert_not(policy.edit?)
    end

    test 'returns true for admin' do
      admin = users(:github)
      admin.update(role: :admin)
      user = users(:google)

      policy = UserPolicy.new(user, user: admin)

      assert_predicate(policy, :edit?)
    end
  end

  class UpdateTest < ActiveSupport::TestCase
    test 'returns false for NOT admin' do
      user = users(:github)

      policy = UserPolicy.new(user:)

      assert_not(policy.update?)
    end

    test 'returns false if admin edit himself' do
      admin = users(:github)
      admin.update(role: :admin)

      policy = UserPolicy.new(admin, user: admin)

      assert_not(policy.update?)
    end

    test 'returns true for admin' do
      admin = users(:github)
      admin.update(role: :admin)
      user = users(:google)

      policy = UserPolicy.new(user, user: admin)

      assert_predicate(policy, :update?)
    end
  end
end
