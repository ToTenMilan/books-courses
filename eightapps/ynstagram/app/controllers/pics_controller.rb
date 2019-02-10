class PicsController < ApplicationController
  before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @pics = Pic.all.order('created_at DESC')
  end

  def new
    @pic = current_user.pics.build
  end

  def show
  end
  
  def create
    @pic = current_user.pics.build(pic_params)
    if @pic.save
      redirect_to @pic, notice: "Pic successfully created"
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @pic.update(pic_params)
      redirect_to @pic, notice: "Pic was successfully updated"
    else
      flash[:error] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    if @pic.destroy
      redirect_to pics_url, notice: 'Pic was successfully deleted.'
    else
      flash[:error] = 'Something went wrong'
      redirect_to pics_url
    end
  end

  def upvote
    @pic.upvote_by current_user
    redirect_back fallback_location: pic_path(@pic)
  end

  private

  def pic_params
    params.require(:pic).permit(:title, :description, :image)
  end

  def find_pic
    @pic = Pic.find(params[:id])
  end
end
