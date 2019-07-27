v = 'success'

Foo = Class.new do
  puts "#{v} from Foo"

  def bar
    # v needed here too
  end
end
