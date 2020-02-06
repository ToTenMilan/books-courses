require 'rspec'

#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---

class RecurringPayment
  def self.process_subscriptions(subscriptions)
    subscriptions.each do |subscription|
      CashCow.charge_card(subscription.credit_card, subscription.amount)
      # ...send receipt and other stuff...
    end
  end
end

Card = Struct.new(:type, :number)
Subscription = Struct.new(:name, :credit_card, :amount)

RSpec.describe RecurringPayment do
  it 'charges the credit card for each subscription' do
    card_1 = Card.new(:visa, '1234 5678 9012 3456')
    card_2 = Card.new(:mastercard, '9876 5432 1098 7654')

    subscriptions = [
      Subscription.new('John Doe', card_1, 19.99),
      Subscription.new('Jane Doe', card_2, 29.99)
    ]

    expect(CashCow).to receive(:charge_card).with(card_1, 19.99)
    expect(CashCow).to receive(:charge_card).with(card_2, 29.99)

    RecurringPayment.process_subscriptions(subscriptions)
  end
end

# some time later, when there are more customers, we decide to make charging a bulk
class RecurringPayment
  def self.process_subscriptions(subscriptions)
    cards_and_amounts = subscriptions.each_with_object({}) do |sub, data|
      data[sub.credit_card] = sub.amount
    end

    CashCow.bulk_charge_cards(cards_and_amounts) # BUT bulk_charge_cards is not mocked, We DO NOT want to run this method on CashCow from specs
    # ...send receipts and other stuff...
  end
end

# adding argument that lets us inject billing object to `process_subscriptions`
class RecurringPayment
  def self.process_subscriptions(subscriptions, bank: CashCow) # inject `bank:`
    subscriptions.each do |subscription|
      bank.charge_card(subscription.credit_card, subscription.amount) # call charging method on injected code,
      # ...send receipt and other stuff...
    end
  end
end
