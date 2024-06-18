class RequestOrderFulfillmentJob < ApplicationJob
  def perform(order_id)
    order = Order.find(order_id)
    OrderCreator.new.request_order_fulfillment(order)
  end
end
