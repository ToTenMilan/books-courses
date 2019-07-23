#### with bug
# class Roulette
#   def method_missing(name, *args)
#     # no super
#     person = name.to_s.capitalize
#     3.times do
#       number = rand(10) + 1
#       puts "#{number}..."
#     end
#     puts "#{person} got a #{number}" # 'number' is in scope of block so this line dont see it and thinks its a method. This method do not exist so its calling is overriden 'method_missing'
#   end
# end


class Roulette
  def method_missing(name, *args)
    # no super
    person = name.to_s.capitalize
    super unless %[Bob Frank Bill].include? person
    number = 0
    3.times do
      number = rand(10) + 1
      puts "#{number}..."
    end
    puts "#{person} got a #{number}" # number is in scope now
  end
end