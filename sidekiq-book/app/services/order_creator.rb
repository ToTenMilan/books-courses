class OrderCreator

  CONFIRMATION_EMAIL_TEMPLATE_ID = "order-confirmation"

  # START:main-logic
  def create_order(order)
    if order.save
      def complete_order(order)
        payments_response = charge(order)
        if payments_response.success?

          email_response       = send_email(order)
          fulfillment_response = request_fulfillment(order)

          order.update!(
            charge_id: payments_response.charge_id,
            charge_completed_at: Time.zone.now,
            charge_successful: true,
            email_id: email_response.email_id,
            fulfillment_request_id: fulfillment_response.request_id)
        else
          order.update!(
            charge_completed_at: Time.zone.now,
            charge_successful: false,
            charge_decline_reason: payments_response.explanation
          )
        end
      end
      # CompleteOrderJob.perform_async(order.id)
    end
    order
  end
  # END:main-logic

  # def complete_order(order)
  #   payments_response = charge(order)
  #   if payments_response.success?

  #     email_response       = send_email(order)
  #     fulfillment_response = request_fulfillment(order)

  #     order.update!(
  #       charge_id: payments_response.charge_id,
  #       charge_completed_at: Time.zone.now,
  #       charge_successful: true,
  #       email_id: email_response.email_id,
  #       fulfillment_request_id: fulfillment_response.request_id)
  #   else
  #     order.update!(
  #       charge_completed_at: Time.zone.now,
  #       charge_successful: false,
  #       charge_decline_reason: payments_response.explanation
  #     )
  #   end
  # end

private

  def charge(order)
    charge_metadata = {}
    charge_metadata[:order_id] = order.id
    # If you place idempotency_key into the metadata, it
    # will pass it to the service.
    #
    #   idempotency_key: "idempotency_key-#{order.id}",
    #
    payments.charge(
      order.user.payments_customer_id,
      order.user.payments_payment_method_id,
      order.quantity * order.product.price_cents,
      charge_metadata
    )
  end

  def send_email(order)
    email_metadata = {}
    email_metadata[:order_id] = order.id
    email_metadata[:subject] = "Your order has been received"
    email.send_email(
      order.email,
      CONFIRMATION_EMAIL_TEMPLATE_ID,
      email_metadata
    )
  end

  def request_fulfillment(order)
    fulfillment_metadata = {}
    fulfillment_metadata[:order_id] = order.id
    fulfillment.request_fulfillment(
      order.user.id,
      order.address,
      order.product.id,
      order.quantity,
      fulfillment_metadata
    )
  end

  def payments    = PaymentsServiceWrapper.new
  def email       = EmailServiceWrapper.new
  def fulfillment = FulfillmentServiceWrapper.new

end
