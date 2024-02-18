class Subscription
  def self.create(email, stripe_token, plan_id, description='none')
    Stripe::Customer.create(email:       email,
                            description: description,
                            card:        stripe_token,
                            plan:        plan_id)
  end

  def self.update(customer_id, plan_id)
    customer = Stripe::Customer.retrieve(customer_id)
    customer.update_subscription(plan: plan_id)
  end

  def self.cancel(customer_id)
    customer = Stripe::Customer.retrieve(customer_id)
    customer.cancel_subscription
  end
end
