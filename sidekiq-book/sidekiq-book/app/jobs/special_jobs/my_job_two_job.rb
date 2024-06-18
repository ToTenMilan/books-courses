class SpecialJobs::MyJobTwoJob < ApplicationJob
  sidekiq_options queue: "high"

  def perform(args,should,go,here)
    raise "This job has not been implemented"
  end
end

