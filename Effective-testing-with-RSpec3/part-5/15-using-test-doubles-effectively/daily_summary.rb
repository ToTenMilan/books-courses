require 'rspec'

#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
class DailySummary
  def send_daily_summary(user_email, todays_messages)
    message_count = todays_messages.count
    thread_count  = todays_messages.map { |m| m[:thread_id] }.uniq.count
    subject       = 'Your daily message summary'
    body          = "You missed #{message_count} messages " \
                    "in #{thread_count} threads today"

    deliver(email: user_email, subject: subject, body: body)
  end

  def deliver(email:, subject:, body:)
    # send the message via SMTP
  end
end

##### check below spec that follows "given, when, then" flow
# RSpec.describe DailySummary do
#   let(:todays_messages) do
#     [
#       { thread_id: 1, content: 'Hello world' },
#       { thread_id: 2, content: 'I think forums are great' },
#       { thread_id: 2, content: 'Me too!' }
#     ]
#   end

#   it "sends a summary of today's messages and threads" do
#     summary = DailySummary.new
#     # need of mocking this method, is a hint that DailySummary should be separated in two objects
#     # not bad but could be better. Check refactored_daily_summary.rb
#     expect(summary).to receive(:deliver).with(
#       hash_including(body: 'You missed 3 messages in 2 threads today')
#     )

#     summary.send_daily_summary('user@example.com', todays_messages)
#   end
# end

RSpec.describe DailySummary do
  let(:todays_messages) do
    [
      { thread_id: 1, content: 'Hello world' },
      { thread_id: 2, content: 'I think forums are great' },
      { thread_id: 2, content: 'Me too!' }
    ]
  end

  it "sends a summary of today's messages and threads" do
    email_sender = instance_spy(EmailSender)
    summary = DailySummary.new(email_sender: email_sender)

    summary.send_daily_summary('user@example.com', todays_messages)

    expect(email_sender).to have_received(:deliver).with(
      hash_including(body: 'You missed 3 messages in 2 threads today')
    )
  end
end
