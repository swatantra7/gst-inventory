class Item < ApplicationRecord

  include ReferenceId
  include PublicActivity::Common

  referenced_with prefix: :IN

  validates_presence_of :name,
            :product_model_number

  validates :quantity, 
            :unit_value,
            presence: true,
            numericality: true

  before_save :write_value!
  
  has_many :orders
  belongs_to :user

  def write_value!
    self.value = quantity*unit_value
  end

  def write_order_attributes!(quantity)
    io = orders.new
    io.quantity = quantity
    io.amount = calculate_order_amount(quantity)
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

