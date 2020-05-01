# If service is to slow to respond below lower timeout, or if task is critical
# use background job, and retyr job on failures

# app/jobs/send_order_job.rb
class SendOrderJob < Struct.new(:message, :action_links)
  def perform(order)
    OrderSender.send_order(order)
  end
end

# app/controllers/orders_controller.rb
def create
  Delayed::Job.enqueue(SendOrderJob.new(order))
end
