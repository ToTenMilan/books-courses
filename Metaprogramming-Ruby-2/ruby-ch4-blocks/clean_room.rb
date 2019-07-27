class CleanRoom
  def current_temperature
    rand(30)
  end
end

clean_room = CleanRoom.new

clean_room.instance_eval do
  if current_temperature < 20
    p "jacket wore"
  end
end

