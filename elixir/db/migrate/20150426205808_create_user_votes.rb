class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer :optionNum
      t.timestamps
    end
  end
end
