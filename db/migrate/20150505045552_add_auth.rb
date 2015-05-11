class AddAuth < ActiveRecord::Migration
  def change
  	add_column :normal_users, :encrypted_password, :string
  	add_column :normal_users, :email, :string

  	add_column :doctors, :username, :string
  	add_column :doctors, :email, :string
  	add_column :doctors, :encrypted_password, :string
  	add_column :doctors, :salt, :string
  	
  end
end
