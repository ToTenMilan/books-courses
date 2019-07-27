v = 'success'

Foo = Class.new do
  puts "#{v} from Foo"

  define_method :bar do
    puts "#{v} from Foo#bar"
  end
end

Foo.new.bar