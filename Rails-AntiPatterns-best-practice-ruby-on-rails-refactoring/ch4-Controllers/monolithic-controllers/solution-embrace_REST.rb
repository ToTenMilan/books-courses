# Antipattern (rarely occurs these days, mostly in rails 1-2)
class AdminController < ApplicationController
  def users
    per_page = Variable::default_pagination_value
    @users = User.find(:all)
    if !params[:operation].nil? then
      if (params[:operation] == 'reset_password') then
        # ...
      if (params[:operation] == 'delete_user') then
        # ...
      if (params[:operation] == 'delete_user') then
        # ...
      if (params[:operation] == 'show_user') then
        # ...
      end
    end
  end
end



# solution
class UsersController < ApplicationController
  def index
    # ...
  end

  def show
    # ...
  end

  def destroy
    # ...
  end
end

class PasswordsController < ApplicationController
  def create

  end
end

class ActivationsController < ApplicationController
  def create

  end
end

# config/routes.rb
namespace :admin do
  resources :users, only: [:index, :show, :destroy] do
    resources :passwords, only: [:create]
    resources :activtions, only: [:create]
  end
end
