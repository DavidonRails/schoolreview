class AddTableCourse < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.belongs_to :university
      t.belongs_to :major
      t.string :description
      t.integer :rating
    end
  end
end
