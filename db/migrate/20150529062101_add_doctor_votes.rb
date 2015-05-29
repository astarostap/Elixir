class AddDoctorVotes < ActiveRecord::Migration
  def change
  	jb = DoctorVote.new(:optionNum => 1, :question_id => 1, :doctor_id => 1)
    jb.save(:validate => false)
    ph = DoctorVote.new(:optionNum => 2, :question_id => 2, :doctor_id => 2)
    ph.save(:validate => false)
    mc = DoctorVote.new(:optionNum => 1, :question_id => 3, :doctor_id => 3)
    mc.save(:validate => false)
    bo = DoctorVote.new(:optionNum => 2, :question_id => 4, :doctor_id => 4)
    bo.save(:validate => false)
    sc = DoctorVote.new(:optionNum => 1, :question_id => 5, :doctor_id => 5)
    sc.save(:validate => false)
    jo = DoctorVote.new(:optionNum => 2, :question_id => 6, :doctor_id => 6)
    jo.save(:validate => false)
  end
end