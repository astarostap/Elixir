class PaperId < ActiveRecord::Migration
  def change
  	add_column :papers, :question_id, :integer
  end
end
