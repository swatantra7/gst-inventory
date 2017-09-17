class Item < ApplicationRecord

  include ReferenceId

  referenced_with prefix: :IN

  validates_presence_of :name,
            :product_model_number

  validates :quantity, 
            :unit_value,
            presence: true,
            numericality: true

  before_save :write_value!
  
  has_many :orders

  def write_value!
    self.value = quantity*unit_value
  end

  def write_order_attributes!(quantity)
    puts "1111111111111#{quantity}"
    io = orders.new
    io.quantity = quantity
    io.amount = calculate_order_amount(quantity)
    puts "111111111111111111111#{io.inspect}"
    io.save
  end

  def calculate_order_amount(quantity)
    quantity*unit_value
  end

  def update_item_detail
    update_attributes(quantity: remaining_quantity, value: updated_value)
  end

  def remaining_quantity
    quantity_change[0] - quantity_change[1]
  end

  def updated_value
    remaining_quantity*unit_value
  end

end

