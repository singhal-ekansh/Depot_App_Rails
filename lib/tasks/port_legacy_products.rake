namespace :custom_tasks do
  task :port_legacy_products => :environment do
    Product.all.each do |product|
      product.update_column(:category_id, Category.first.id) if product.category.nil?
    end
  end
end