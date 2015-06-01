class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title
      t.text :text
      t.text :option1
      t.text :option2
      t.timestamps
    end
  end
end
