class CompleteOrderJob
  include Sidekiq::Job

  def perform(order_id)
    sleep(rand * 2.0)
    order = Order.find(order_id)
    OrderCreator.new.complete_order(order)
  rescue BaseServiceWrapper::HTTPError => ex
    raise IgnorableExceptionSinceSidekiqWillRetry.new(ex)
  end
end
