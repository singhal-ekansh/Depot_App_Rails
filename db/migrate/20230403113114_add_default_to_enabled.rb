class AddDefaultToEnabled < ActiveRecord::Migration[7.0]
  def change
    change_column_default :products, :enabled, from: nil, to: false
    # change_column_default :products, :enabled, false  (this will be irreversable)
  end
end
