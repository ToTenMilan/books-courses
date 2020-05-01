# Antipattern
class UsersController < ApplicationController
  def login
    # ...
  end

  def logout
    # ...
  end

  # ... other restful actions
end



# solution

class SessionsController < ApplicationController
  def new
    # ...
  end

  def create
    # ...
  end

  def destroy
    # ...
  end
end

# config/routes.rb
resource :sessions, only: [:new, :create, :destroy] # singular resource (create less routes)
match "/login" => "sessions#new", as: :login
match "/logout" => "sessions#destroy", as: :logout
