class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :agreesNum
      t.text :text
      t.timestamps
    end
  end
end
