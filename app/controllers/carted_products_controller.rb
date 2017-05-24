class CartedProductsController < ApplicationController

  before_action :authenticate_user! 

  def index
    #find open order for current user
    @order = Order.find_by(user_id: current_user.id, completed: false) 
    #if our order has carted product(s) 
    if @order.carted_products.length > 0 
    #call all carted products for open order
      @carted_products = @order.carted_products
      render "index.html.erb"
    else
      flash[:warning] = "Your cart is empty!"
      redirect_to "/"
    end
  end

  def create
    #check if an order is open for current user (completed:false)
    order = Order.find_by(user_id: current_user.id, completed: false)
    if order
      order_id = order.id

    #if not, create new order
    else
      order = Order.create(
        user_id: current_user.id,
        completed: false  
        )
      order_id = order.id
    end

    #then create new carted_product
    new_product = CartedProduct.create(
      product_id: params[:product_id], 
      quantity: params[:quantity],
      #use order_id from open order or from newly created order
      order_id: order_id
      )

    flash[:success] = "You added #{new_product.product.name} to your cart!"
    redirect_to "/carted_products"
  end

  def destroy
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.destroy
    redirect_to "/carted_products"
  end

end
