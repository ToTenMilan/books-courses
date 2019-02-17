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

  def edit
    find_play
    find_review
  end

  def update
    find_play
    find_review
    if @review.update(review_params)
      flash[:success] = "Review was successfully updated"
      redirect_to play_path(@play)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    find_play
    find_review
    if @review.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to play_path(@play)
    else
      flash[:error] = 'Something went wrong'
      redirect_to play_path(@play)
    end
  end
  
  
  private

    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_play
      @play = Play.find(params[:play_id])
    end

    def find_review
      @review = Review.find(params[:id])
    end
end
