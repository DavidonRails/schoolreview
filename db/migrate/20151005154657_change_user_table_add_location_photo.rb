class ChangeUserTableAddLocationPhoto < ActiveRecord::Migration
  def change
    change_column :users, :first_name, :string, null: true
    change_column :users, :last_name, :string, null: true
    add_column :users, :location, :string
    add_column :users, :profile_photo, :string
  end
end
