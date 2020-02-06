#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'twitter'

class TwitterUserFormatter
  def initialize(user)
    @user = user
  end

  def format
    @user.name + "'s website is " + @user.url # name and url comes from Twitter::User
  end
end


# its tempting to mock Twitter::User like so:
RSpec.describe TwitterUserFormatter do
  it 'describes their homepage' do
    user = instance_double(Twitter::User,
                           name: 'RSpec',
                           url: 'http://rspec.info')

    formatter = TwitterUserFormatter.new(user)

    expect(formatter.format).to eq("RSpec's website is http://rspec.info")
  end
end
# but since gem twitter 5.0 Twitter::User#url returns URI object, not a string, so test will give false positive
# but moving into production
# after upgrade we will get a TypeError with the message "no implicit conversion of URI::HTTPS into String"

# in this scenario, we may depend on e2e tests, or:
# 1. use high-fidelity fake
# 2. write wrapper around API

# ad 1. services often ships with its fakes for testing i.e:
  # LDAP => FakeLDAP
  # Redis => FakeRedis
  # Bunny => BunnyMock
  # Braintree => FakeBraintree
  # Fog gem(Cloud Services adapter) comes with mocks

