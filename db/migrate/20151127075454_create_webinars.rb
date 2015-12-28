class CreateWebinars < ActiveRecord::Migration
  def change
    create_table :webinars do |t|
      t.string :name
      t.string :filepath
      t.string :participates, array: true, default: []
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
