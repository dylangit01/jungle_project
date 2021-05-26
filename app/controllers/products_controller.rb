class ProductsController < ApplicationController

  # For showing all products
  def index
    @products = Product.all.order(created_at: :desc)
  end

  # For displaying single item
  def show
    @product = Product.find params[:id]
  end

end
