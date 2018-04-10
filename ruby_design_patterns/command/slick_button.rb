class SlickButton
  attr_accessor :command

  def initialize(command)
    @command = command
  end

  def on_button_push
    @command.execute if @command
  end
end

class SaveCommand
  def execute
    puts 'Someone pushed me'
  end
end

save_button = SlickButton.new( SaveCommand.new )
save_button.on_button_push
