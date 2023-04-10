class ChangePermalinkType < ActiveRecord::Migration[7.0]
  def change
    #irreversible migraton
    change_column :products, :permalink, :text
  end
end
