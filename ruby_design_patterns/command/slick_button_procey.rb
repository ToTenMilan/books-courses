class SlickButton < Proc
  attr_accessor :command

  def initialize(&block)
    @command = block
  end

  def on_button_push
    @command.call if @command
  end
end

new_button = SlickButton.new do
  puts 'Ive been pushed'
end

# procy = Proc.new do
#   puts 'iam a proc'
# end

# puts new_button.class

button = SlickButton.new(&new_button)
button.on_button_push