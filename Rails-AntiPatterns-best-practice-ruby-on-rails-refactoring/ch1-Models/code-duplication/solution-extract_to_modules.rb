# Antipattern
class Car < ActiveRecord::Base
  def accelarate
    self.speed = speed + 10
  end

  def brake
    self.speed = 0
  end
end

class Truck < ActiveRecord::Base
  def accelarate
    self.speed = speed + 10
  end

  def brake
    self.speed = 0
  end
end



# solution - Template pattern
module Driveable
  class TemplateError < RuntimeError; end

  def top_speed
    raise TemplateError, 'not implemented'
  end

  def accelarate
    self.speed = [speed + accelaration, top_speed].min
  end

  def brake
    self.speed = 0
  end
end

class Car < ActiveRecord::Base
  include Driveable

  def top_speed
    200
  end

  def accelaration
    10
  end
end

class Truck < ActiveRecord::Base
  include Driveable

  def top_speed
    100
  end

  def accelaration
    6
  end
end

# place Driveable in lib/ and require in config/initializers/requires.rb
Dir[File.join(Rails.root, 'lin', '*.rb')].each { |f| require f }
