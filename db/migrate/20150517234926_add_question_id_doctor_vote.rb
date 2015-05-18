class AddQuestionIdDoctorVote < ActiveRecord::Migration
  def change
  	add_column :doctor_votes, :question_id, :integer
  end
end
