# Antipattern
# consider two scenarios
# 1. listing all messages from all users route
# 2. listing all messages of single user route

# Putting these two scenarios in one controller forces us to use `if` to differentiate behavior
class MessagesController < ApplicationController
  def index
    if params[:user_id]
      @user = user.find(params[:user_id])
      @messages = @user.messages
    else
      @messages = Message.all
    end
  end
end

# config/routes.rb
resources :messages
resources :messages do
  resources :messages
end



# solution
class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
end

class Users::MessagesController < ApplicationController
  def index
    @user = user.find(params[:user_id])
    @messages = @user.messages
  end
end

# config/routes.rb
resources :messages
resources :messages do
  resources :messages, controller: 'users/messages'
end
