class AddQbIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :qb_id, :integer
  end
end
