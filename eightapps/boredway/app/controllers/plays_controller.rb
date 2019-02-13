class PlaysController < ApplicationController
  before_action :find_play, only: [:show, :edit, :update, :destroy]
  def index
    @plays = Play.all.order('created_at DESC')
  end

  def new
    @play = Play.new
  end

  def show
  end

  def create
    @play = Play.new(play_params)
    if @play.save
      flash[:success] = "Play successfully created"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @play.update_attributes(play_params)
      flash[:success] = "Object was successfully updated"
      redirect_to @play
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end
  
  def destroy
    if @play.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to plays_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to plays_url
    end
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director)
  end

  def find_play
    @play = Play.find(params[:id])
  end  
end
