class AddDocGender < ActiveRecord::Migration
  def change
  	add_column :doctors, :gender, :text

  end
end
