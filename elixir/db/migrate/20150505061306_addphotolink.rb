class Addphotolink < ActiveRecord::Migration
  def change
  	add_column :questions, :photo_link, :string
  end
end
