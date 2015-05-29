class AddAttributesAgrees < ActiveRecord::Migration
  def change
  	add_column :agrees, :is_doctor, :integer
	add_column :agrees, :vote_value, :integer
	rename_column :agrees, :doctor_id, :voter_id
  end
end