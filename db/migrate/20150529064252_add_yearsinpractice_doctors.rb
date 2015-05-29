class AddYearsinpracticeDoctors < ActiveRecord::Migration
  def change
  	add_column :doctors, :years_in_practice, :integer
  end
end