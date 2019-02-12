class PlaysController < ApplicationController
  def index
    @plays = Play.all
  end

  def new
    @play = Play.new
  end
  
  def create
    @play = Play.new(play_params)
    if @play.save
      flash[:success] = "Play successfully created"
      redirect_to @play
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  private

  def play_params
    params.require(:play).permit(:title, :description, :director)
  end
  
end
