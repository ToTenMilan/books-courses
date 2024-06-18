require 'test_helper'
require 'sidekiq_middleware/server/silence_transient_errors'

class SidekiqMiddleware::Server::SilenceTransientErrorsTest < ActiveSupport::TestCase
  setup do
    @payments_service_status = ServiceStatus.find('payments')
    @payments_service_status.update(sleep: 0, throttle: false, crash: false)
    Sidekiq::Testing.server_middleware do |chain|
      chain.add SidekiqMiddleware::Server::SilenceTransientErrors
    end
  end

  test 'normal job raising a non-transient exception' do
    job_instance = CompleteOrderJob.new
    non_existent_order_id = -99
    CompleteOrderJob.perform_async(non_existent_order_id)
    assert_raises(ActiveRecord::RecordNotFound) do
      Sidekiq::Worker.drain_all
    end
  end

  test 'normal job raising a transient exception' do
    @payments_service_status.update(sleep: 0, throttle: false, crash: true)
    order = FactoryBot.create(:order)
    CompleteOrderJob.perform_async(order.id)
    assert_raises(IgnorableExceptionSinceSidekiqWillRetry) do
      Sidekiq::Worker.drain_all
    end
  end

  class CustomTransientJob < ApplicationJob
    def self.transient_exceptions
      [ ArgumentError ]
    end
    def perform(throw_argument_error)
      raise ArgumentError
    end
  end

  test 'job raising a custom transient exception' do
    order = FactoryBot.create(:order)
    CustomTransientJob.perform_async(true)
    assert_raises(IgnorableExceptionSinceSidekiqWillRetry) do
      Sidekiq::Worker.drain_all
    end
  end
end
