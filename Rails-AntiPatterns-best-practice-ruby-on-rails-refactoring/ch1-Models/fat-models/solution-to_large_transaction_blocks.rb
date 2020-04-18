##### Antipattern
class Account < ActiveRecord::Base
  def create_account!(...)
    transaction do
    account = Account.create!(...)
    user = User.new(...)
    user.admin = true
    user.save!
    self.usres << user
    account.save!
    Mailer.deliver_conf(...)
    account
  end
end



##### Solution
class Account < ActiveRecord::Base
  accepts_nested_attributes_for :users # creation is handled by account form with `fields_for` user

  before_create :make_admin_user
  after_create :send_confirmation_email

  private

    def make_admin_user
      # ...
    end

    def send_confirmation_email
      # ...
    end
end
