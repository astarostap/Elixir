class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.integer :docScore
      t.text :specialty
      t.text :school
      t.text :knownFor
      
      t.timestamps
    end
  end
end
