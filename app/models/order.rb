class Order < ApplicationRecord

  belongs_to :item

  after_save :write_item_attribute!

  validate :order_quantity

  private

  def write_item_attribute!
    item.value = calcualte_remaing_amount
    item.quantity = calcualte_remaing_quantity
    item.save(validates: false)
  end

  def calcualte_remaing_amount
    calcualte_remaing_quantity*(item.unit_value)
  end

  def calcualte_remaing_quantity
    (item.quantity - quantity)
  end

  def order_quantity
    if quantity > item.quantity || quantity == 0
      errors.add(:base, :invalid_file_format)
    end
  end

end
