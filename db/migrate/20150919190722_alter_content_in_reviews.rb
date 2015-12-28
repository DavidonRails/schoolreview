class AlterContentInReviews < ActiveRecord::Migration
  def change
    change_column :reviews, :content, :string
  end
end
