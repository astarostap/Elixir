class AddUseridDoctorfieldToResponses < ActiveRecord::Migration
  def change
  	add_column :responses, :user_id, :integer
  	add_column :responses, :is_doctor, :integer
  end
end
