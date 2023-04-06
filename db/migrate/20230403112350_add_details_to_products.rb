class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :products do |t|
      t.column :enabled, :boolean
      t.column :discount_price, :decimal, precision: 8, scale: 2
      t.column :permalink, :string
    end

    # add_column :products, :enabled, :boolean
    # add_column :products, :discount_price, :decimal, precision: 8, scale: 2
    # add_column :products, :permalink, :string
  end
end
