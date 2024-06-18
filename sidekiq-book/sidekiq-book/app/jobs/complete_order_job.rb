class CompleteOrderJob < ApplicationJob

  sidekiq_options queue: :high

  def perform(order_id)
    order = Order.find(order_id)
    OrderCreator.new.complete_order(order)
  end
end
