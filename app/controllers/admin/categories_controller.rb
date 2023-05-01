module Admin
  class CategoriesController < ApplicationController
    include AdminAccess
    before_action :only_admin_access

    def index
      @categories = Category.all
    end

    def products
      @products = Category.find(params[:id]).products
      @products += Category.find(params[:id]).sub_category_products
      
    end
  end
end