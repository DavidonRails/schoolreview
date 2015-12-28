class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :university, null: false
      t.belongs_to :user, null: false
      t.string :title, null: false
      t.integer :rating, null: false
      t.integer :content, null: false
      t.timestamps null: false
    end
  end
end
