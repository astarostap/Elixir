class CreateNormalUsers < ActiveRecord::Migration
  def change
    create_table :normal_users do |t|
      t.string :username, :salt
      t.timestamps
    end
  end
end
