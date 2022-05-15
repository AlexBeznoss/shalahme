module UserPhoneNumbersHelper
  BASE_URL = 'https://avatars.dicebear.com/api/'.freeze

  def phone_logo_url(phone)
    [
      BASE_URL,
      'initials',
      '/',
      CGI.escape([phone.name, phone.id].join),
      '.svg'
    ].join
  end
end
