# Use sidekiq for all jobs, drop activejob

class ApplicationJob
  include Sidekiq::Worker
  # client middleware - run code around job is enqueued
  # server middleware - run code around job is executed
end
