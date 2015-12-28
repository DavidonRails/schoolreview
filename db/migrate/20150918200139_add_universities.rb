class AddUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string "name", null: false
      t.string 'location', null: false
      t.string 'description', null: false
      t.timestamps null: false
    end
  end
end
