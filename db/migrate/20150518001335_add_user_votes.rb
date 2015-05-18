class AddUserVotes < ActiveRecord::Migration
  def change
  	jb = UserVote.new(:optionNum => 1, :question_id => 1)
    jb.save(:validate => false)
    ph = UserVote.new(:optionNum => 2, :question_id => 2)
    ph.save(:validate => false)
    mc = UserVote.new(:optionNum => 1, :question_id => 3)
    mc.save(:validate => false)
    bo = UserVote.new(:optionNum => 2, :question_id => 4)
    bo.save(:validate => false)
    sc = UserVote.new(:optionNum => 1, :question_id => 5)
    sc.save(:validate => false)
    jo = UserVote.new(:optionNum => 2, :question_id => 6)
    jo.save(:validate => false)
  end
end