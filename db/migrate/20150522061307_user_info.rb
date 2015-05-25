class UserInfo < ActiveRecord::Migration
  def change
  	add_column :normal_users, :birth_date, :datetime
  	add_column :normal_users, :gender, :text
  	add_column :normal_users, :location, :text
  end
end
