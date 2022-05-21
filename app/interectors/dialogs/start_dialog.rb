# frozen_string_literal: true

module Dialogs
  class StartDialog
    include Interactor::Organizer

    organize CreateRecipient, CreateDialog, CreateMessage
  end
end
