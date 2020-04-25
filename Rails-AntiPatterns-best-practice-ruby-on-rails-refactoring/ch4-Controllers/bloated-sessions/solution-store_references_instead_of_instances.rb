##### Antipattern
class OrdersController < ApplicationController
  def new
    session[:order] = Order.new
  end

  def billing
    session[:order].attributes = params[:order]
    if !session[:order].valid?
      render action: :billing
    end
  end

  def shipping
    session[:order].attributes = params[:order]
    if !session[:order].valid?
      render action: :shipping
    end
  end

  def payment
    session[:order].attributes = params[:order]
    if !session[:order].valid?
      render action: :payment
    end
  end

  def create
    if session[:order].save
      flash[:success] = "Order places successfully"
      redirect_to order_path(session[:order])
    else
      render action: :payment
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end

# config/routes.rb
resources :posts do
  collection do
    post :shipping # /orders/shipping
    post :billing
    post :payment
  end
end




##### solution 1 - storing order steps in database (for more complex scenarios)
# App need to deal with unfinished orders
class OrdersController < ApplicationController
  def new
    session[:order] = Order.new
  end

  def billing
    @order = Order.find_by(id: params[:id])
    if !@order.update_attributes(params[:order])
      render action: :billing
    end
  end

  def shipping
    @order = Order.find_by(id: params[:id])
    if !@order.update_attributes(params[:order])
      render action: :shipping
    end
  end

  def payment
    @order = Order.find_by(id: params[:id])
    if !@order.update_attributes(params[:order])
      render action: :payment
    end
  end

  def create
    Order.find_by(id: params[:id])
    if @order.update_attributes(params[:order])
      flash[:success] = "Order places successfully"
      redirect_to order_path(session[:order])
    else
      render action: :payment
    end
  end

  def show
    @order = Order.find_by(id: params[:id])
  end
end

resources :posts do
  member do
    post :shipping # /orders/1/shipping
    post :billing
    post :payment
  end
end




###### solution 2 - steps of order are not saved beetwen requests
# app do not need to deal with unfinished orders
class OrdersController < ApplicationController
  def new
    session[:order] = Order.new
  end

  def billing
    @order = Order.new(params[:order])
    if @order.valid?
      render action: :billing
    end
  end

  def shipping
    @order = Order.new(params[:order])
    if @order.valid?
      render action: :shipping
    end
  end

  def payment
    @order = Order.new(params[:order])
    if @order.valid?
      render action: :payment
    end
  end

  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:success] = "Order places successfully"
      redirect_to order_path(session[:order])
    else
      render action: :payment
    end
  end

  def show
    @order = Order.find(params[:id])
  end
end

# config/routes.rb
resources :posts do
  collection do
    post :shipping # /orders/shipping
    post :billing
    post :payment
  end
end
