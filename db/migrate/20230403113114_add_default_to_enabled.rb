class AddDefaultToEnabled < ActiveRecord::Migration[7.0]
  def change
    change_column_default :products, :enabled, false 
  end
end
