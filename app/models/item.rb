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

  private

  def write_value!
    self.value = calculate_item_value
  end

  def calculate_item_value
    calculate_item_price +  calculate_gst_price
  end

  def calculate_item_price
    unit_value * quantity
  end

  def calculate_gst_price
    (unit_value*gst_percentage/100) * quantity
  end

end

