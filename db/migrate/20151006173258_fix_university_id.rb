class FixUniversityId < ActiveRecord::Migration
  def change
    rename_column :programs, :university_id, :institution_id
    rename_column :reviews, :university_id, :institution_id
  end
end
