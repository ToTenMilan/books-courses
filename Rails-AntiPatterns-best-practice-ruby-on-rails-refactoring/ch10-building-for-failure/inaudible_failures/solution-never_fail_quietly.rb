# Antipattern
class Ticket < ActiveRecord::Base
  def self.bulk_change_owner(user)
    all.each do |ticket|
      ticket.owner = user
      ticket.save # `save` returns `nil` when cant save, so fails quietly. Nobody knows about the error
    end
  end
end



# solution
class Ticket < ActiveRecord::Base
  def self.bulk_change_owner(user)
    transaction do # added transaction for consistency. User wont be left with part of data updated and part not
      all.each do |ticket|
        ticket.owner = user
        ticket.save! # `save!` raises error on save
      end
    end
  end
end

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors

  # ...

  private

  def show_errors
    # ...
  end
end
