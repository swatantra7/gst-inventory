class AddColumnGstPercentageToOrders < ActiveRecord::Migration[5.0]
  def change
  	add_column :orders, :gst_percentage, :float
  end
end
