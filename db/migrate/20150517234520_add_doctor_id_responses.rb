class AddDoctorIdResponses < ActiveRecord::Migration
  def change
  	add_column :responses, :doctor_id, :integer
  end
end
