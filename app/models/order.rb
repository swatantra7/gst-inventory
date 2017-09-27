class Order < ApplicationRecord

  include ReferenceId

  include PublicActivity::Common

  referenced_with prefix: :ON

  belongs_to :item
  belongs_to :user

  after_save :write_item_attribute!

  validate :order_quantity, :order_amount

  delegate :name, :product_model_number, :unit_value,:vendor_url, :location, to: :item, allow_nil: true

  private

  def write_item_attribute!
    item.value = calcualte_remaing_amount
    item.quantity = calcualte_remaing_quantity
    item.save(validates: false)
  end

  def calcualte_remaing_amount
    item.value - amount
  end

  def calcualte_remaing_quantity
    (item.quantity - quantity)
  end

  def order_quantity
    if quantity > item.quantity || quantity == 0
      errors.add(:base, :invalid)
    end
  end

  def order_amount
    if amount > item.value || amount == 0
      errors.add(:base, :invalid)
    end
  end

end
