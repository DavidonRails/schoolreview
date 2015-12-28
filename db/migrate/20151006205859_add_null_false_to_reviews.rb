class AddNullFalseToReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :program_id, :integer, null: false
  end

  def down
    change_column :reviews, :program_id, :integer, null: true
  end
end
