# frozen_string_literal: true

module Dialogs
  class CreateDialog
    include Interactor

    def call
      dialog = Dialog.create_or_find_by(
        recipient_phone_number: context.recipient,
        user_phone_number: context.user_phone_number
      )

      if dialog.errors.empty?
        context.dialog = dialog
      else
        context.fail!(errors: dialog.errors)
      end
    end
  end
end
