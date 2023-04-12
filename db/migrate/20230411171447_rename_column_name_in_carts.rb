class RenameColumnNameInCarts < ActiveRecord::Migration[7.0]
  def change
    rename_column :carts, :line_item_count, :line_items_count
  end
end
