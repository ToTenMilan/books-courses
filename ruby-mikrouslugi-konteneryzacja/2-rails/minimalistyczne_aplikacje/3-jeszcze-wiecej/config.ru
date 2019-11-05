require 'action_controller/railtie'
require 'coderay'

class HelloController < ActionController::Base
  def world
    render inline: "
      <!DOCTYPE html>
      <title>The Smallest Rails App</title>
      <h3>I am the smallest rails app!</h3>
      <p>Here is my source code:</p>
      #{CodeRay.scan_file(__FILE__, :ruby).div(line_numbers: :table)}
      <a href='https://github.com/artemave/thesmallestrailsapp.com'>Make me smaller</a>
    "
  end # world
end # HelloController

run HelloController.action(:world)