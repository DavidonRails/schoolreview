class ChangeTableInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :type, :string
  end
end
