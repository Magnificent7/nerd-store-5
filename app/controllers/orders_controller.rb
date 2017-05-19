class OrdersController < ApplicationController

  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    product = Product.find_by(id: product_id)
    calculated_subtotal = product.price.to_i * quantity
    calculated_tax = calculated_subtotal * 0.09
    calculated_total = calculated_subtotal + calculated_tax

    order = Order.create(
      user_id: current_user.id,
      product_id: product_id,
      quantity: quantity,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total
      )
    flash[:success] = "Order Successfully Made!"
    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find_by(id: params[:id])
  end
end
