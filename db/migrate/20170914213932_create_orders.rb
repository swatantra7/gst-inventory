class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
    	t.integer :item_id
    	t.decimal :amount
    	t.integer :quantity
      t.timestamps
    end
  end
end
