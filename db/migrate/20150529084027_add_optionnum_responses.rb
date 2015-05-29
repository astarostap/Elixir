class AddOptionnumResponses < ActiveRecord::Migration
  def change
  	add_column :responses, :option_num, :integer
  end
end
