class MessagesController < ApplicationController
  def index
    @messages = Message.all.order('created_at DESC')
  end
  
  def new
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
  end
  
  
  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "Message successfully created"
      redirect_to @message
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  
  private

  def message_params
    params.require(:message).permit(:title, :description)
  end
end
