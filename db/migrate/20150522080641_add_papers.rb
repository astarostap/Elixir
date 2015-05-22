class AddPapers < ActiveRecord::Migration
def change
  	jb = Paper.new(:optionNum => 1, :question_id => 1, :doctor_id => 1, :url => "https://www.healthtap.com/user_questions/1566682")
    jb.save(:validate => false)
    ph = Paper.new(:optionNum => 2, :question_id => 1, :doctor_id => 2, :url => "http://www.livescience.com/34693-superfoods.html")
    ph.save(:validate => false)
    mc = Paper.new(:optionNum => 1, :question_id => 2, :doctor_id => 3, :url => "https://www.healthtap.com/user_questions/1301456")
    mc.save(:validate => false)
    bo = Paper.new(:optionNum => 2, :question_id => 2, :doctor_id => 4, :url => "http://www.health.harvard.edu/blog/trade-sports-drinks-for-water-201207305079")
    bo.save(:validate => false)
    sc = Paper.new(:optionNum => 1, :question_id => 3, :doctor_id => 5, :url => "http://www.mensfitness.com/nutrition/supplements/6-supplements-you-shouldnt-be-skipping")
    sc.save(:validate => false)
    jo = Paper.new(:optionNum => 2, :question_id => 4, :doctor_id => 6, :url => "http://www.webmd.com/fitness-exercise/build-muscle-better-health")
    jo.save(:validate => false)
  end
end
