# most common candidates to be moved to background job
# 1. generating reports
# 2. updating lots of related data in an associated object, based on a user action
# 3. updating various caches
# 4. communicating with slower external resources
# 5. sending email


# solution 1
# use cron task, where job needs to be done is exactly known, i.e. count all rows and cache the number on a very large data



# solution 2
# use queueing when You dont know yet what needs to be done, i.e. users is requesting a report to be generated or sending an email
# delayed-job example
class SalesReport < Struct.new(:user)
  def perform
    report = generate_report
    Mailer.sales_report(user, report).deliver
  end

  private

  def generate_report
    CSV.generate do |csv|
      # ...
    end
  end
end


# app/controllers/reports_controller.rb
def create
  Delayed::Job.enqueue(SalesReport.new(current_user))
end


# or using send_later
class Sale < ActiveRecord::Base
  def self.generate_report(user)
    report = CSV.generate do |csv|
      # ...
    end
    Mailer.sales_report(user, report).deliver
  end
end

# app/controllers/reports_controller.rb
def create
  Sale.send_later(:generate_report, current_user)
end


# For more complex job logic, choose job classes
