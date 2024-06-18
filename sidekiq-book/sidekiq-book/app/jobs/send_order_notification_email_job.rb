class SendOrderNotificationEmailJob < ApplicationJob

  def perform(order_id)
    order = Order.find(order_id)
    OrderCreator.new.send_notification_email(order)
  rescue BaseServiceWrapper::HTTPError => ex
    raise IgnorableExceptionSinceSidekiqWillRetry.new(ex)
  end
end
