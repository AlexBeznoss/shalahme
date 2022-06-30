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

  def local_time(time)
    time_tag(
      time,
      class: 'hidden',
      data: {
        controller: 'local-time',

        'local-time-format-value': 'MMMM D, h:mm A',
        'local-time-utc-value': time.in_time_zone.utc.to_i
      }
    )
  end

  def frontend_redirect_to(path)
    tag.div(data: { controller: 'frontend-redirect', 'frontend-redirect-path-value': path })
  end

  def user_has_ready_numbers?
    cache_key = "#{current_user.id}_has_ready_number"
    Rails.cache.fetch(cache_key, expires_in: 20 * 60) do
      current_user.phone_numbers.ready.any?
    end
  end

  private

  def nav_link_active?(url)
    current_page?(url) ||
      (signed_in? && request.path == '/' && url == dashboard_path) ||
      (url.start_with?('/convos') && request.path.start_with?('/convos'))
  end
end
