class AddProfilepicDoctors < ActiveRecord::Migration
  def change
  	add_column :doctors, :profile_pic, :string
  end
end