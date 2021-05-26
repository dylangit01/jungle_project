class Admin::DashboardController < Admin::BaseAdminController
  def show
    @products = Product.all
    @product_count = Product.sum('quantity')
    @categories = Category.all
    @category_count = Category.count

  end
end
