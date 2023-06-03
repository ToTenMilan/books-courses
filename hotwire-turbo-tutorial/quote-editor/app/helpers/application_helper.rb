module ApplicationHelper
  def render_turbo_stream_flash_message
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end
end
