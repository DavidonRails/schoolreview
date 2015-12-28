class ChangeReviewTable < ActiveRecord::Migration
  def change
    add_column :reviews, :program_id, :integer
  end
end
