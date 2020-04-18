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



# Solution - Rails plugin (Engine) - Rails 3 way
module Driveable
  module ActiveRecordExtensions
    class ClassMethods
      def driveable
        include ActiveRecordExtensions::InstanceMethods
      end
    end

    module InstanceMethods
      def brake
        self.speed = 0
      end

      def accelarate
        self.speed = [speed + 10, 100].min
      end
    end
  end
end

# lib/dirveable.rb
require "driveable/active_record_extensions"

class ActiveRecord::Base
  extend Driveable::ActiveRecordExtensions::ClassMethods
end
