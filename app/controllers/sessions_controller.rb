# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    info = request.env['omniauth.auth']
    user = User.create_or_find_by(provider: info['provider'], uid: info['uid'])
    user.update!(
      name: info.dig('info', 'name'),
      email: info.dig('info', 'email'),
      logo_url: info.dig('info', 'image')
    )

    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
