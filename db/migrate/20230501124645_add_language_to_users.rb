class AddLanguageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :language_pref, :string, default: 'english'
  end
end
