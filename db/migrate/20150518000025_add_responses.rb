class AddResponses < ActiveRecord::Migration
  def change
  	jb = Response.new(:text => "so dumb", :agreesNum => 1, :doctor_id => 1)
    jb.save(:validate => false)
    ph = Response.new(:text => "so beautiful", :agreesNum => 2, :doctor_id =>2)
    ph.save(:validate => false)
    mc = Response.new(:text => "so smart", :agreesNum => 3, :doctor_id => 3)
    mc.save(:validate => false)
    bo = Response.new(:text => "so insightful", :agreesNum => 4, :doctor_id => 4)
    bo.save(:validate => false)
    sc = Response.new(:text => "so helpful", :agreesNum => 5, :doctor_id => 5)
    sc.save(:validate => false)
    jo = Response.new(:text => "so life-changing!", :agreesNum => 6, :doctor_id => 6)
    jo.save(:validate => false)
  end
end