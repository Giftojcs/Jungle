class Admin::DashboardController < ApplicationController
  def index
    @product_count = Product.count
    @category_count = Category.count
  end
end  # This is the missing 'end' for the class
