class PlaysController < ApplicationController
  def index
    @plays = Play.all
  end
  
end
