module Admin
  class CategoriesController < Admin::BaseController
    def index
      @categories = Category.all
    end

    def products
      @products = Category.find(params[:id]).products
      @products += Category.find(params[:id]).sub_category_products
      
    end
  end
end