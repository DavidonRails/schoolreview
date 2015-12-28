class FixTableProgramColumnName < ActiveRecord::Migration
  def change
    rename_column :programs, :murl, :url
  end
end
