class ReviewsController < ApplicationController
  def new
    find_play
    @review = Review.new
  end

  def create
    find_play
    @review = Review.new(review_params)
    @review.update(play_id: @play.id, user_id: current_user.id)
    if @review.save
      flash[:success] = "Object successfully created"
      redirect_to play_path(@play)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  private

    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_play
      @play = Play.find(params[:play_id])
    end
end
