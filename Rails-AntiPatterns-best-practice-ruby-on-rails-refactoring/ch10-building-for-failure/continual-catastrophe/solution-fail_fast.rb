# Antipattern - fail in the middle of work
class Portfolio < ActiveRecord::Base
  def self.close_all
    all.each do |portfolio|
      unless portfolio.photos.empty?
        # imagine this error will be raised on 50th portfolio out of 100. User will be left with 50 portfolios
        raise 'cant close a portfolio with photos'
      end
      portfolio.close!
    end
  end
end



# solution - fail fast
class Portfolio < ActiveRecord::Base
  def self.close_all
    all.each do |portfolio|
      unless portfolio.photos.empty?
        raise 'cant close a portfolio with photos'
      end
    end

    # delete only after ensuring that all portfolios could be deleted
    all.each do |portfolio|
      portfolio.close!
    end
  end
end


# or do checks on view layer for better UI
class Portfolio < ActiveRecord::Base
  def self.can_close_all?
    !all.any? { |portfolio| portfolio.photos.empty? }
  end

  def self.close_all
    raise 'cant close a portfolio with photos' unless can_close_all?

    # delete only after ensuring that all portfolios could be deleted
    all.each do |portfolio|
      portfolio.close!
    end
  end
end

# view
- if Portfolio.can_close_all?
  link_to "Close All", close_all_portfilios_url, method: :post



# solution example 2
def fire_all_weapons
  ensure_authorized!
  ensure_non_friedndly_target!
  ensure_loaded!

  weapons.each(&:fire!)
end
