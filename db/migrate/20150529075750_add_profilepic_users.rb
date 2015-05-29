class AddProfilepicUsers < ActiveRecord::Migration
  def change
  	add_column :normal_users, :profile_pic, :string
  end
end
