# frozen_string_literal: true

module Dialogs
  class FindUserNumber
    Error = Struct.new(:full_message)
    Errors = Struct.new(:full_message) do
      def has_key?(key)
        key == :user_number_id
      end

      def each(&)
        [Error.new(full_message)].each(&)
      end
    end

    include Interactor

    def call
      number = UserPhoneNumber.find_by(
        id: context.params[:user_number_id],
        user: context.user,
        status: :ready
      )

      if number
        context.user_phone_number = number
      else
        context.fail!(errors: build_errors)
      end
    end

    private

    def build_errors
      Errors.new('Your number is not accessible right now, try again later.')
    end
  end
end
