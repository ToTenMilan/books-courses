#---
# Excerpted from "Effective Testing with RSpec 3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/rspec3 for more book information.
#---
require 'skier'
require 'trail_map'

module Mountain
  RSpec.describe Skier do
    it 'gets tired after skiing a difficult slope' do
      #   double wont be verified if TrailMap wont be loaded to this spec or mistyped
      # trail_map = instance_double('TrailMap', difficulty: :expert)

      #   implicit `Mountain` inside module is OK (assuming 'trail_map.rb' is loaded)
      # trail_map = instance_double(TrailMap, difficulty: :expert)
      
      #   String version is OK, but bugs may slip into
      #   Good when dependency dont exist (yet), but expensive to load
      # trail_map = instance_double('Mountain::TrailMap', difficulty: :expert)

      # the best is to use classes explicitly
      trail_map = instance_double(Mountain::TrailMap, difficulty: :expert) # OK

      # just for testing configuration to verify mocked doubles
      # trail_map = instance_double('TrailMap', difficulty: :expert) # =>
        # => "TrailMap" is not a defined constant. Perhaps you misspelt it?
        # -> Disable check with `verify_doubled_constant_names` configuration option.

      skier = Skier.new(trail_map)
      skier.ski_on('Last Hoot')
      expect(skier).to be_tired
    end
  end
end
