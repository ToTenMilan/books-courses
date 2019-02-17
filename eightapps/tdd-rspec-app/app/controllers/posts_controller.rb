class PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find(params[:id])
  end
  

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "Post successfully created"
      redirect_to @post
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :caption)
  end
end
