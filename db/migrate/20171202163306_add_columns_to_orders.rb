class AddColumnsToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :placed_at_uts, :integer
    add_column :orders, :customer_name, :string
    add_column :orders, :payment_mode, :string
  end
end
