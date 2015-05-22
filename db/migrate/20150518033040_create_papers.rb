class CreatePapers < ActiveRecord::Migration
  def change
    create_table :papers do |t|
    	t.integer :optionNum
    	t.string :url
    	t.integer :doctor_id
    	t.integer :question_id
      t.timestamps
    end
  end
end