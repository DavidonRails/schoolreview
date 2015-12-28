class AddColumniToUniversities < ActiveRecord::Migration
  def change
    add_column :universities, :major, :string, null: false
  end
end
