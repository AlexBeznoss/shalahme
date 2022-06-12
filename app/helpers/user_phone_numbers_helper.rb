# frozen_string_literal: true

module UserPhoneNumbersHelper
  BASE_URL = 'https://avatars.dicebear.com/api/'

  def user_phone_logo_url(phone)
    [
      BASE_URL,
      'initials',
      '/',
      CGI.escape([phone.name, phone.id].join),
      '.svg'
    ].join
  end
end
