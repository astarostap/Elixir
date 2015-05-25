class AddDocBirthdate < ActiveRecord::Migration
  def change
  	add_column :doctors, :birth_date, :datetime
  end
end
