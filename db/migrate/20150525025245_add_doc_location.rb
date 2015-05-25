class AddDocLocation < ActiveRecord::Migration
  def change
  	  	add_column :doctors, :location, :text
  end
end
