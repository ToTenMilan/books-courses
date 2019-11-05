%w(action_controller/railtie).map &method(:require)

run TheSmallestRailsApp ||= Class.new(Rails::Application) {
  config.secret_token = routes.append { root to: 'hello#world' }.inspect
  initialize!
} # run

class HelloController < ActionController::Base
  def world
    render inline: "<!DOCTYPE html>
      <title>The Smallest Rails App</title>
      <h3>I am the smallest rails app!</h3>
      <p>Hello, world!</p>"
  end # world
end # HelloController