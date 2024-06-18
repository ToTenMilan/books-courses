# Use sidekiq for all jobs, drop activejob

class ApplicationJob
  include Sidekiq::Worker
  # Automatically retry jobs that encountered a deadlock
  # retry_on ActiveRecord::Deadlocked

  # Most jobs are safe to ignore if the underlying records are no longer available
  # discard_on ActiveJob::DeserializationError
end
