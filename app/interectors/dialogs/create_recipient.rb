# frozen_string_literal: true

module Dialogs
  class CreateRecipient
    include Interactor

    def call
      recipient = RecipientPhoneNumber.find_or_create_by(number: context.params[:number])

      if recipient.errors.empty?
        context.recipient = recipient
      else
        context.fail!(errors: recipient.errors)
      end
    end

    def rollback
      context.recipient.destroy! unless context.recipient.dialogs.exists?
    end
  end
end
