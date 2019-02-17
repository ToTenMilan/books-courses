class PlaysController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :find_play, only: [:show, :edit, :update, :destroy]

  def index
    if params[:category].blank?
      Rails.logger.info 'category blank = ============='
      @plays = Play.all.order('created_at DESC')
    else
      @category_id = Category.find_by(name: params[:category]).id
      @plays = Play.where(category_id: @category_id).order('created_at DESC')
    end
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map { |c| [c.name, c.id]}
  end

  def show
    # if @play.reviews.blank?
    #   @average_review = 0
    # else
      @average_review = @play.reviews.average(:rating)&.round(2)
    # end
  end

  def create
    @play = current_user.plays.build(play_params)
    @play.category_id = params[:category_id]
    # @play.update(play_params)

    if @play.save
      flash[:success] = "Play successfully created"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map { |c| [c.name, c.id]}
  end
  
  def update
    @play.category_id = params[:category_id]
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
    params.require(:play).permit(:title, :description, :director, :category_id, :image)
  end

  def find_play
    @play = Play.find(params[:id])
  end  
end
