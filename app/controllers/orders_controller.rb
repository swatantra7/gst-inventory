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

end
