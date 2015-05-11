class CreateAgrees < ActiveRecord::Migration
  def change
    create_table :agrees do |t|
      t.timestamps
    end
  end
end
