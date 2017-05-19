class Product < ActiveRecord::Base

  belongs_to :supplier
  has_many :images
  has_many :orders
  has_many :category_products
  has_many :categories, through: :category_products

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
