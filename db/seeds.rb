# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


questions_list = [
  [ "Are superfoods a real thing?", "What should I buy at the grocery store to stay healthy? Which foods are superfoods?", "No such thing", "There are superfoods", "http://www.itslavida.com/files/2015/01/superfoods-1000x500.jpg", 1],
  [ "Is gatorade better for you than water when exercising?", "What to do if I do an hour full body workout should what to do if i drink water or gatorade while i work out?", "Gatorade", "Water", "http://briangreen.net/files/2013/10/elixir-00-640x480.jpg", 1 ],
  [ "Are supplements necessary to build muscle mass?", "Are supplements necessary to build muscle mass?", "Supplements are necessary to build muscle mass.", "Muscle mass can be built through exercise.", "http://cosmouk.cdnds.net/15/11/nrm_1425906239-pillsandsupplements.jpg", 2],
  [ "Does lactic acid cause muscle soreness?", "I’ve heard lactic acid is caused by soreness. Is this true?", "Lactic acid causes delayed onset muscle soreness", "Delayed onset muscle soreness is a natural outcome of physical activity.", "http://www.bicyclestore.com.au/media/wysiwyg/LacticA.jpg", 2],
  [ "Am I in good health if I have a good BMI reading?", "I received a good BMI rating last time at the doctors? Am I healthy?", "BMI should be used to evaluate good health.", "Waist circumference should be added to BMI to evaluate good health.", "http://www.apotheke-innsbruck.at/page/media/bmi.jpg", 3],
  [ "Should eggs be a part of a healthy diet?", "Can I now eat eggs as a part of a healthy diet? ", "Eggs cause heart disease.", "Effect of egg consumption on blood cholesterol is minimal.", "https://moviewriternyu.files.wordpress.com/2013/10/eggs.jpg", 3],
  [ "Should I be supplementing my diet with vitamin E?", "Does supplemental vitamin E protect against disease?", "Vitamin E protects against disease.", "Supplementing with Vitamin E may slightly lower lifespan.", "http://www.empoweringeverydaywomen.com/images/easter-eggs1000.jpg", 4],
  [ "Does the idea that herbal supplements are natural mean they are safe?", "Can herbal supplements be taken like medicine?", "Herbal supplements are natural and good for you.", "Some herbal supplements cause liver toxicity.", "http://hairsupplements.org/wp-content/uploads/2014/03/HairSupplements1.jpg", 4],
  [ "Will an antibiotic cure a cold?", "Why won’t my doctor give me an antibiotic for my cold?", "Antibiotics are for colds.", "Antibiotics should be used in the treatment of bacterial infections.", "http://www.pbiforum.net/images/cache/1000x500/crop/images%7Ccms-image-000000894.jpg", 5],
  [ "Are ulcers caused by stress?", "Is it true that certain foods cause ulcers?", "Ulcers are caused by stress, food, and spices.", "Ulcers are caused by the bacteria Helicobacter pylori.", "http://indianparentsforum.com/home/wp-content/uploads/2015/03/how-to-deal-with-stress.jpg", 5]
]

questions_list.each do |title, text, option1, option2, photo_link, normal_user_id|
  Question.create( title: title, text: text, option1: option1, option2: option2, photo_link: photo_link, normal_user_id: normal_user_id)
end


