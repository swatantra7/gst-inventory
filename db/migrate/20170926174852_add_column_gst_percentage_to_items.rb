class AddColumnGstPercentageToItems < ActiveRecord::Migration[5.0]
  def change
  	add_column :items, :gst_percentage, :float
  end
end
