class ProductsController < ApplicationController
  def index

    if session[:count] == nil
      session[:count] = 0
    end
    session[:count] += 1
    @visits = session[:count]

    @products = Product.all
    sort_attribute = params[:sort]
    sort_order = params[:order]
    discount = params[:discount]
    if sort_attribute && sort_order
      @products = Product.all.order(sort_attribute => sort_order)
    end
    if discount
      @products = Product.where("price < ?", "3")
    end
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    @product = Product.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      supplier_id: params[:supplier]["supplier_id"]
    )
    flash[:success] = "Product Created"
    redirect_to "/products/#{@product.id}"
  end

  def show
    @product = Product.find_by(id: params[:id])
    if params[:id] == "random"
      @product = Product.all.sample
    end
    render "show.html.erb"
  end

  def edit
    @product = Product.find_by(id: params[:id])
    render "edit.html.erb"
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update(
      name: params[:name],
      description: params[:description],
      image: params[:image],
      price: params[:price]
    )
    flash[:success] = "Product Updated"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    flash[:warning] = "Product Destroyed"
    redirect_to "/"
  end
end

