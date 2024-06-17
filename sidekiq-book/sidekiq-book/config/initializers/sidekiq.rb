Sidekiq.configure_server do |config|
  config.death_handlers << ->(job, exception) {
    ErrorCatcherServiceWrapper.new.notify(
      "#{job['class']} won't be retried: #{exception.message}"
    )
  }

  config.error_handlers << ->(exception, context_hash) {
    ErrorCatcherServiceWrapper.new.notify(exception)
  }

end
