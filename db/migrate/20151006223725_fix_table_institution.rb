class FixTableInstitution < ActiveRecord::Migration
  def change
    rename_column :institutions, :type, :learning_mode 
  end
end
