Rails.application.config.to_prepare do
  # ErrorCatcherServiceWrapper.ignored_errors << error class here
  ErrorCatcherServiceWrapper.ignored_errors << IgnorableExceptionSinceSidekiqWillRetry
end
