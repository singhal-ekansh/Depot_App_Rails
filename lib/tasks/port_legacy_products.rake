namespace :product_namespace do
  task :port_legacy_products => :environment do
    first_category_id = Category.first.id
    Product.all.each do |product|
      product.update(:category_id, product.category_id ||= first_category_id)
    end
  end
end