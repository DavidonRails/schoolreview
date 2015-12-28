class CreateJointTableUserProgramAttendancy < ActiveRecord::Migration
  def change
    create_table :user_program_attendancies do |t|
      t.belongs_to :user, null: false
      t.belongs_to :program, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :location
      t.string :url
    end
  end
end
