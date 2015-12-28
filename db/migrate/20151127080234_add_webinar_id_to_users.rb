class AddWebinarIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :webinar_id, :integer
  end
end
