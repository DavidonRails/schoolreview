class ChangeUniversityTable < ActiveRecord::Migration
  def change
    change_table :universities do |t|
      t.remove :location
      t.string :city, null: false
      t.string :state, null: false
      t.string :country, null: false
    end
  end
end
