# frozen_string_literal: true

module Dialogs
  class StartDialog
    include Interactor::Organizer

    organize FindUserNumber, CreateRecipient, CreateDialog
  end
end
