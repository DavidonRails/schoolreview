class AddMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :title, null: false
      t.string :description
      t.string :level
      t.belongs_to :university
    end
  end
end
