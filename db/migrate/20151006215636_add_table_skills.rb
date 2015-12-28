class AddTableSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string "name", null: false
      t.string "description", null: false
      t.integer "points", null: false
      t.belongs_to :program
      t.belongs_to :user
      
      t.timestamps null: false
    end
  end
end
