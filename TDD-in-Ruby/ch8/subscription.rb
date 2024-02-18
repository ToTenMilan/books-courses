class Subscription
  def self.create(email, stripe_token, plan_id, description='none')
    Stripe::Customer.create(email:       email,
                            description: description,
                            card:        stripe_token,
                            plan:        plan_id)
  end
end
