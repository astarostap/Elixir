class CreateNormalUsers < ActiveRecord::Migration
  def change
    create_table :normal_users do |t|
      t.string :username
      t.string :salt
      t.timestamps
    end
  end
end
