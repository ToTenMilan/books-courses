require "test_helper"

class OrderCreatorTest < ActiveSupport::TestCase
  setup do
    @order_creator = OrderCreator.new
  end

  test "create_order charge declines" do
    order = Order.create!(
      email: "pat@example.com",
      address: "123 Main St",
      quantity: 1,
      product: create(:product,:priced_for_decline),
      user: create(:user)
    )
    resulting_order = @order_creator.create_order(order)
    assert_equal order, resulting_order, "should return the same order"
    Sidekiq::Job.drain_all
    resulting_order.reload
    refute resulting_order.charge_successful
    assert_equal "Insufficient funds", resulting_order.charge_decline_reason
    assert_nil resulting_order.charge_id
  end

  test "create_order charge succeeds" do
    order = Order.create!(
      email: "pat@example.com",
      address: "123 Main St",
      quantity: 2,
      product: create(:product, quantity_remaining: 3),
      user: create(:user),
    )

    resulting_order = @order_creator.create_order(order)
    assert_equal order, resulting_order, "should return the same order"
    Sidekiq::Job.drain_all
    resulting_order.reload
    assert resulting_order.charge_successful
    assert_nil resulting_order.charge_decline_reason
    refute_nil resulting_order.charge_id
    refute_nil resulting_order.email_id
    refute_nil resulting_order.fulfillment_request_id
  end

  test "send_notification_email uses existing email" do
    email_service_wrapper = EmailServiceWrapper.new
    order = Order.create!(
      email: "pat@example.com",
      address: "123 Main St",
      quantity: 1,
      product: create(:product),
      user: create(:user),
    )

    # Pretend the email was sent in a previous execution
    previously_sent_email = email_service_wrapper.send_email(
      order.email,
      OrderCreator::CONFIRMATION_EMAIL_TEMPLATE_ID,
      {
        order_id: order.id
      }
    )

    email_id = previously_sent_email.email_id
    assert_not_nil email_id, "expected an email to have been send"

    # Grab a count of the emails matching before running the test
    matching_emails = email_service_wrapper.search_emails(
      order.email,
      OrderCreator::CONFIRMATION_EMAIL_TEMPLATE_ID
    )
    num_matching_emails = matching_emails.count

    # Test starts here
    @order_creator.send_notification_email(order)
    order.reload
    assert_equal email_id, order.email_id, "A different email was sent than the previously-sent one"

    # Re-fetch the emails so we can count them
    matching_emails = email_service_wrapper.search_emails(
      order.email,
      OrderCreator::CONFIRMATION_EMAIL_TEMPLATE_ID
    )
    assert_equal num_matching_emails, matching_emails.count, "An email was sent that should have been"
  end
end
