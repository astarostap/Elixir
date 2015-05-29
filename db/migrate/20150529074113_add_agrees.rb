class AddAgrees < ActiveRecord::Migration
  def change
  	jb = Agree.new(:response_id => 1, :voter_id => 1, :is_doctor => 0, :vote_value => 1)
    jb.save(:validate => false)
    ph = Agree.new(:response_id => 2, :voter_id =>2, :is_doctor => 1, :vote_value => -1)
    ph.save(:validate => false)
    mc = Agree.new(:response_id => 3, :voter_id => 3, :is_doctor => 0, :vote_value => -1)
    mc.save(:validate => false)
    bo = Agree.new(:response_id => 4, :voter_id => 4, :is_doctor => 1, :vote_value => 1)
    bo.save(:validate => false)
    sc = Agree.new(:response_id => 5, :voter_id => 5, :is_doctor => 0, :vote_value => -1)
    sc.save(:validate => false)
    jo = Agree.new(:response_id => 6, :voter_id => 6, :is_doctor => 1, :vote_value => 1)
    jo.save(:validate => false)
  end
end