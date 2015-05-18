class AddResponseIdDoctorIdAgree < ActiveRecord::Migration
  def change
  	add_column :agrees, :response_id, :integer
  	add_column :agrees, :doctor_id, :integer
  end
end
