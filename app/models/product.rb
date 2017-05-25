class Product < ActiveRecord::Base

  belongs_to :supplier
  has_many :images
  has_many :category_products
  has_many :categories, through: :category_products
  has_many :carted_products
  has_many :orders, through: :carted_products

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: true
  validates :description, presence: true
  validates :description, length: {maximum: 500}


  def sale_message
    if price.to_i <= 2
      return "Discount Item"
    else
      return "Everyday Value"
    end
  end

  def tax
    price.to_i * 0.09
  end

  def total
    price.to_i + tax
  end

end
