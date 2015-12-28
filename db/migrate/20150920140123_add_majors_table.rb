class AddMajorsTable < ActiveRecord::Migration
  def change
    create_table :majors do |t|
      t.string :title, null: false
      t.string :level, null: false
    end
  end
end
