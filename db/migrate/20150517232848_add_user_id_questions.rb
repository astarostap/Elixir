class AddUserIdQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :normal_user_id, :integer
  end
end
