class ItemsController < ApplicationController
  # before_action :authenticate_user!
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
    if user_signed_in?
      @items = Item.where(user_id: current_user.id).order(created_at: 'DESC')
    end
  end
  
  def new
    @item = current_user.items.build
  end

  def show
  end
  
  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "Item successfully created"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @item.update(item_params)
      flash[:success] = "Item was successfully updated"
      redirect_to @item
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @item.destroy
      flash[:success] = 'Item was successfully deleted.'
      redirect_to root_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to root_path
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:title, :description)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
