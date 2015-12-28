class DropTableMajorsAndCourses < ActiveRecord::Migration
  def change
    drop_table :courses
    drop_table :majors
  end
end
