# frozen_string_literal: true

module Authentication
  def sign_in(user, method_name = :get)
    info = prep_social_info_from(user)
    OmniAuth.config.add_mock(user.provider.to_sym, info)

    public_send(
      method_name,
      "/auth/#{user.provider}/callback"
    )
  end

  def assert_requires_authentication_for(method_name, path)
    public_send(method_name, path)

    assert_redirected_to root_path
    assert_equal I18n.t('login_warning'), flash[:warning]
  end

  private

  def prep_social_info_from(user)
    {
      provider: user.provider,
      uid: user.uid,
      info: {
        name: user.name,
        email: user.email,
        image: user.logo_url
      }
    }
  end
end
