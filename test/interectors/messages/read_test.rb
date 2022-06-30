# frozen_string_literal: true

require 'test_helper'

module Messages
  module ReadTest
    class WhenNotRead < ActiveSupport::TestCase
      include ActiveJob::TestHelper

      setup do
        @user = create(:user)
        @message = create(:message, :inbound, read: false)
      end

      test 'updates read to true' do
        assert_changes -> { @message.reload.read? }, from: false, to: true do
          Messages::Read.call(current_user: @user, message: @message)
        end
      end

      test 'enqueue broadcast for counter update' do
        expected_channels = ["#{@message.dialog.to_gid_param}:convo", "#{@user.to_gid_param}:dialogs"]
        expected_partials = Array.new(2) { 'dialogs/read_counter' }
        expected_targets = [
          "dialog_#{@message.dialog.id}_read_counter_show",
          "dialog_#{@message.dialog.id}_read_counter_index"
        ]

        assert_enqueued_jobs 2, only: Turbo::Streams::ActionBroadcastJob do
          Messages::Read.call(current_user: @user, message: @message)
        end

        args = enqueued_jobs.pluck(:args)
        assert_equal args.map(&:first), expected_channels
        assert_equal args.map { |a| a.last['target'] }, expected_targets
        assert_equal args.map { |a| a.last['partial'] }, expected_partials
      end
    end

    class WhenAlreadyRead < ActiveSupport::TestCase
      include ActiveJob::TestHelper

      setup do
        @user = create(:user)
        @message = create(:message, :inbound, read: true)
      end

      test 'not changes message' do
        assert_no_changes -> { @message.reload } do
          Messages::Read.call(current_user: @user, message: @message)
        end
      end

      test 'not enqueue jobs' do
        assert_enqueued_jobs 0 do
          Messages::Read.call(current_user: @user, message: @message)
        end
      end
    end
  end
end
