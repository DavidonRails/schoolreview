class MajorSchemaChanges < ActiveRecord::Migration
  def up
    rename_table :universities, :institutions
    rename_table :majors, :programs
  end

  def down
    rename_table :institutions, :universities
    rename_table :programs, :majors
  end
end
