class AddAgrees < ActiveRecord::Migration
  def change
  	jb = Agree.new(:response_id => 1, :doctor_id => 1)
    jb.save(:validate => false)
    ph = Agree.new(:response_id => 2, :doctor_id =>2)
    ph.save(:validate => false)
    mc = Agree.new(:response_id => 3, :doctor_id => 3)
    mc.save(:validate => false)
    bo = Agree.new(:response_id => 4, :doctor_id => 4)
    bo.save(:validate => false)
    sc = Agree.new(:response_id => 5, :doctor_id => 5)
    sc.save(:validate => false)
    jo = Agree.new(:response_id => 6, :doctor_id => 6)
    jo.save(:validate => false)
  end
end