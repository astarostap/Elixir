class VoteUserId < ActiveRecord::Migration
  def change
  	add_column :user_votes, :user_id, :int
  	add_column :doctor_votes, :doctor_id, :int
  end
end
