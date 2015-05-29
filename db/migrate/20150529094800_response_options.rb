class ResponseOptions < ActiveRecord::Migration
  def change
  	add_column :responses, :optionNum, :int
  end
end
