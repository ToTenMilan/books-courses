require 'minitest/autorun'
require 'stripe'
require_relative 'subscription'

# One of the common mistakes developers make is mocking a third-party API.
# Mocking is a design technique. You cannot drive the design of a third-party API.
# However, we can stub them.

# Stubs provide canned answers to calls made during the test.
# —Martin Fowler

describe Subscription do
  it 'subscribe customer to a plan' do
    email = 'bugs.bunny@rubyplus.com'
    plan_id = 'gold'
    stripe_token = 'value does not matter'

    hash = JSON.parse(File.read("fixtures/customer.json"))
    customer = Stripe::Customer.construct_from(hash)

    Stripe::Customer.stub :create, customer do
      customer = Subscription.create(email, stripe_token, plan_id)

      assert_equal 'cus_6XToBT4GczhYXA', customer.id
      assert_equal 'gold', customer.subscriptions.data[0].plan.id
    end
  end
end
