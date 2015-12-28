class AddColumnsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :icons, :string
  end
end
