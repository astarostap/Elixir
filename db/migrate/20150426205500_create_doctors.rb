class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.integer :docScore
      t.string :specialty
      t.string :school
      t.string :knownFor
      
      t.timestamps
    end
  end
end
