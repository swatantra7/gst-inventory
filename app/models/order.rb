class Order < ApplicationRecord

  include ReferenceId

  include PublicActivity::Common

  attr_accessor :_destroy

  referenced_with prefix: :ON

  belongs_to :item
  belongs_to :user

  after_save :write_item_attribute!

  validate :order_quantity, :order_amount

  delegate :name, :product_model_number, :unit_value,:vendor_url, :location, to: :item, allow_nil: true

  scope :placed_orders, ->(placed_time){ where(placed_at_uts: placed_time) }

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
    if quantity.blank? || quantity > item.quantity || quantity == 0
      errors.add(:base, :invalid)
    end
  end

  def order_amount
    if amount.blank? || amount > item.value || amount == 0
      errors.add(:base, :invalid)
    end
  end

end
