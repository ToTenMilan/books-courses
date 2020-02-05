require 'rspec'

#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---

require 'configuration' # some configuration that set min. password length to 8

class PasswordStrengthValidator
  attr_reader :password

  def initialize(password)
    @password = password
  end

  def strong_enough?
    return false unless password.length >= Acme::Config.min_password_length

    # ... more validations ...
    true
  end
end

### this approach works, but is tied to validators implementation, configuration etc.
# so test will fail when password length will change from 8 to i.e. 12
RSpec.describe PasswordStrengthValidator do
  it 'rejects passwords shorter than 8 characters' do # note hardcoded configuartion "8"
    validator = PasswordStrengthValidator.new('a8E^rd2')
    expect(validator.strong_enough?).to eq false
  end

  it 'accepts passwords 8 characters or longer' do
    validator = PasswordStrengthValidator.new('a8E^rd2i')
    expect(validator.strong_enough?).to eq true
  end
end


### instead password requirements can be configured expoicitly in test, to untie it from configuration
RSpec.describe PasswordStrengthValidator do
  before do
    allow(Acme::Config).to receive(:min_password_length).and_return(6) # mock configuration
  end

  it 'rejects passwords shorter than the configured length' do # note hardcoded configuration dissapears
    validator = PasswordStrengthValidator.new('a8E^r')
    expect(validator.strong_enough?).to eq false
  end

  it 'accepts passwords that satisfy the configured length' do
    validator = PasswordStrengthValidator.new('a8E^rd')
    expect(validator.strong_enough?).to eq true
  end
end


