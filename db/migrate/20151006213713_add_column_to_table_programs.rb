class AddColumnToTablePrograms < ActiveRecord::Migration
  def change
    add_column :programs, :status, :string
    add_column :programs, :certification, :string
    add_column :programs, :duration, :string
    add_column :programs, :start_date, :date
    add_column :programs, :end_date, :date
    add_column :programs, :murl, :string
  end
end
