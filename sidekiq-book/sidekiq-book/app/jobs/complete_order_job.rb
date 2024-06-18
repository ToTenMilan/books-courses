class CompleteOrderJob
  include Sidekiq::Job

  sidekiq_options queue: :high

  def perform(order_id)
    order = Order.find(order_id)
    OrderCreator.new.complete_order(order)
  rescue BaseServiceWrapper::HTTPError => ex
    raise IgnorableExceptionSinceSidekiqWillRetry.new(ex)
  end
end
