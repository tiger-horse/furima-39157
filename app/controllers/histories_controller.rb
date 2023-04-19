class HistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index
  before_action :set_prototype, only: [:index, :create]

  def index
    @history_address = HistoryAddress.new
  end

  def create
    @history_address = HistoryAddress.new(history_params)
    if @history_address.valid?
      pay_item
      @history_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_prototype
    @item = Item.find(params[:item_id])
  end

  def history_params
    params.require(:history_address).permit(:post_code, :prefecture_id, :municipality, :address, :building, :tel).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: history_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    @item = Item.find(params[:item_id])
    return unless current_user.id == @item.user.id || @item.history != nil 
    redirect_to root_path
  end
end
