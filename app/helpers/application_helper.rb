# frozen_string_literal: true

module ApplicationHelper
  def nav_link_to(name, url, options = {})
    options[:class] = [
      options[:class],
      nav_link_active?(url) ? 'active' : ''
    ].join(' ')

    link_to name, url, **options
  end

  def root_path
    return dashboard_path if signed_in?

    super
  end

  def content_id
    "#{controller_name.underscore}_#{action_name}"
  end

  def render_flash_stream
    turbo_stream.update 'flash', partial: 'layouts/flash'
  end

  private

  def nav_link_active?(url)
    current_page?(url) ||
      (signed_in? && request.path == '/' && url == dashboard_path)
  end
end
