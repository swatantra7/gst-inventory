class ItemsController < ApplicationController

  before_action :find_item, only: [:edit, :update, :show, :order_item]

  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'item created sucessfully'
      redirect_to items_path
    else
      puts "#{@item.errors.inspect}"
      flash[:alert] = 'item not created'
      redirect_to new_item_path
    end
  end

  def update
    if @item.update_attributes(item_params)
      flash[:notice] = 'item updated sucessfully'
      redirect_to items_path
    else
      flash[:alert] = 'item not updated sucessfully'
      redirect_to items_path
    end
  end

  def order_item
    @order = @item.orders.build(build_attributes)
    if @order.save
      flash[:notice] = 'order placed sucessfully'
      redirect_to order_path(@order)
    else
      flash[:alert] = 'Order quantity should not be zero or less than item quantity'
      redirect_to item_path
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :id,
      :name,
      :description,
      :product_model_number,
      :vendor_part_number,
      :vendor_name,
      :quantity,
      :unit_value,
      :value,
      :picture,
      :vendor_url,
      :category,
      :location,
    )
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def build_attributes
    { quantity: params[:item][:quantity], amount: params[:item][:value] }
  end

end
