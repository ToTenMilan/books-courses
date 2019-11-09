module Schedulable
  attr_writer :schedule
  def schedule
    @schedule ||= ::Schedule.new
  end
  def schedulable?(start_date, end_date)
    !scheduled?(start_date - lead_days, end_date)
  end
  def scheduled?(start_date, end_date)
    schedule.scheduled?(self, start_date, end_date)
  end
  # includers may override
  def lead_days
    0
  end
end