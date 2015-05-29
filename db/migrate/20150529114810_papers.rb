class Papers < ActiveRecord::Migration
  def change
  	add_column :papers, :title, :text
  end
end
