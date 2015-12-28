class DeleteColumnMajorInUniversities < ActiveRecord::Migration
  def change
    remove_column :universities, :major
  end
end
