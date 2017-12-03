class OrdersController < ApplicationController

  def index
    @search = current_user.orders.ransack(params[:q])
    @order = @search.result
  end

  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'receipt',
        template: 'orders/show.html.slim'
      end
    end
  end

  def total_amount
    @item = Item.find(params[:item_id])
    @amount = @item.evaluate_total_sum(params[:quantity].to_f, params[:percentage].to_f)
      respond_to do |format|
      format.json { render json: @amount.to_json }
    end
  end

  def order_detail
    @orders = Order.placed_orders(params[:current_time].to_i)
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'receipt',
        template: 'orders/order_detail.html.slim'
      end
    end
  end

  def new
    @item = Item.first
    @orders = @item.orders.build
  end

end
