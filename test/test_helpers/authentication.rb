module Authentication
  def sign_in(user)
    info = {
      provider: user.provider,
      uid: user.uid,
      info: {
        name: user.name,
        email: user.email,
        image: user.logo_url
      }
    }

    OmniAuth.config.add_mock(user.provider.to_sym, info)

    get "/auth/#{user.provider}/callback"
  end
end
