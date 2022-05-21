# frozen_string_literal: true

require 'test_helper'

module Dialogs
  class StartDialogTest < ActiveSupport::TestCase
    test 'has specific sequence of interactors' do
      assert_equal(
        [CreateRecipient, CreateDialog, CreateMessage],
        StartDialog.organized
      )
    end
  end
end
