class OrdersController < ApplicationController

  def index
    @search = current_user.orders.ransack(params[:q])
    @order = @search.result
  end

  def show
    @order = Order.find(params[:id])
  end

end
