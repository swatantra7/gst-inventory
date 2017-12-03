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

  scope :find_required_items, ->(item_ids){where(id: item_ids)}

  accepts_nested_attributes_for :orders

  def evaluate_total_sum(quantity, percentage)
    evaluate_item_price(quantity) + evaluate_gst_price(percentage, quantity)
  end

  class << self

    def create_bulk_order(params, current_user, current_time)
      ActiveRecord::Base.transaction do
        params.each do |key, value|
          item = current_user.items.find(value[:item_id])
          order = item.orders.build(value)
          order.user_id = current_user.id
          order.placed_at_uts = current_time
          order.save
        end
      end
    end

  end

  private

  def write_value!
    self.value = calculate_item_value
  end

  def calculate_item_value
    calculate_item_price + calculate_gst_price
  end

  def calculate_item_price
    unit_value * quantity
  end

  def calculate_gst_price
    (unit_value*gst_percentage/100) * quantity
  end

  def evaluate_item_price(quantity)
    unit_value * quantity
  end

  def evaluate_gst_price(percentage, quantity)
    (unit_value*percentage/100) * quantity
  end

end

