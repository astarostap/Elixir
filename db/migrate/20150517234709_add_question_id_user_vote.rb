class AddQuestionIdUserVote < ActiveRecord::Migration
  def change
  	add_column :user_votes, :question_id, :integer
  end
end
