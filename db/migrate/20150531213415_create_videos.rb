class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    t.integer :doctor_id
      t.integer :question_id
      t.integer :optionNum
      t.text :url
      t.text :title
      t.timestamps
    end
  end
end
