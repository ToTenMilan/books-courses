require 'minitest/autorun'
require 'stripe'
require_relative 'subscription'

describe Subscription do
  before do
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  end

  it 'subscribe a customer to gold plan' do
    email = 'bugs_bunny@rubyplus.com'
    stripe_token = Stripe::Token.create(card: {
                                          number: "4242424242424242",
                                          exp_month:  7,
                                          exp_year:  2020,
                                          cvc: "314"
                                          })
    # This plan must already exist in your Stripe Test account
    plan_id = 'gold'

    customer = Subscription.create(email, stripe_token.id, plan_id)

    # If there is no exception and the response JSON has the new customer ID then the test passes
    assert customer.id.size > 5
  end
end
