class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_message, only: [:create, :edit, :update, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]
  def create
    @comment = @message.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment successfully created"
      redirect_to message_path(@message)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @comment.update_attributes(comment_params)
      flash[:success] = "Comment was successfully updated"
      redirect_to message_path(@message)
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end
  
  def destroy
    if @comment.destroy
      flash[:success] = 'Comment was successfully deleted.'
      redirect_to message_path(@message)
    else
      flash[:error] = 'Something went wrong'
      redirect_to message_path(@message)
    end
  end
  
  
  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_message
    @message = Message.find(params[:message_id])
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
