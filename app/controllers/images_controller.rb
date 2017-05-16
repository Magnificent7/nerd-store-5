class ImagesController < ApplicationController
  def new
    @product = Product.find(params[:id])
    render 'new.html.erb'
  end

  def create
    id = params[:id] #products id from route
    image = Image.create(
      url: params[:url],
      product_id: id
      )
    flash[:success] = "Image Successfully Created!"
    redirect_to "/products/#{id}"
  end
end
