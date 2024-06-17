Sidekiq.configure_server do |config|
  config.error_handlers << ->(exception, context_hash) {
    ErrorCatcherServiceWrapper.new.notify(exception)
  }
end
