class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_prototype, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy

    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :content, :category_id, :condition_id, :postage_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @item = Item.find(params[:id])
  end

  def move_to_index
    return if current_user.id == @item.user.id && @item.history.nil?

    redirect_to action: :index
  end
end
