class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :text
      t.string :option1
      t.string :option2
      t.timestamps
    end
  end
end
