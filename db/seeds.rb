# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#create users

    nu1 = NormalUser.new(:username => "John", :email => "jpekins@gmail.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Western U.S.", :profile_pic => "prof1.jpg")
    nu1.save(:validate => false)
    nu2 = NormalUser.new(:username => "Tanner", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Western U.S.", :profile_pic => "prof2.jpg")
    nu2.save(:validate => false)
    nu3 = NormalUser.new(:username => "Abraham", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Southern U.S.", :profile_pic => "prof3.jpg")
    nu3.save(:validate => false)
    nu4 = NormalUser.new(:username => "Emily", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Midwest U.S.", :profile_pic => "prof4.jpg")
    nu4.save(:validate => false)
    nu5 = NormalUser.new(:username => "Oneida", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Western U.S.", :profile_pic => "prof5.jpg")
    nu5.save(:validate => false)
    nu6 = NormalUser.new(:username => "Thanh", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Midwest U.S.", :profile_pic => "prof6.jpg")
    nu6.save(:validate => false)
    nu7 = NormalUser.new(:username => "Abe", :email => "jpekins@gmail.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Eastern U.S.", :profile_pic => "prof7.jpg")
    nu7.save(:validate => false)
    nu8 = NormalUser.new(:username => "Morgan", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Western U.S.", :profile_pic => "prof8.jpg")
    nu8.save(:validate => false)
    nu9 = NormalUser.new(:username => "Oracle", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Southern U.S.", :profile_pic => "prof9.jpg")
    nu9.save(:validate => false)
    nu10 = NormalUser.new(:username => "Linux", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Midwest U.S.", :profile_pic => "prof10.jpg")
    nu10.save(:validate => false)
    nu11 = NormalUser.new(:username => "HP", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Eastern U.S.", :profile_pic => "prof11.jpg")
    nu11.save(:validate => false)
    nu12 = NormalUser.new(:username => "Costco", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Midwest U.S.", :profile_pic => "prof1.jpg")
    nu12.save(:validate => false)

    for user in NormalUser.all
        salt = SecureRandom.hex
        user[:salt] = salt
        result = salt + user[:username]
        digest = Digest::SHA2.hexdigest(result)
        user[:encrypted_password] = digest
        user.save
    end

    nd1 = Doctor.new(:username => "drJohn", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100, :years_in_practice => 17, :profile_pic => "prof11.jpg")
    nd1.save(:validate => false)
    nd2 = Doctor.new(:username => "drTanner", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70, :years_in_practice => 16, :profile_pic => "prof10.jpg")
    nd2.save(:validate => false)
    nd3 = Doctor.new(:username => "drAbraham", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80, :years_in_practice => 15, :profile_pic => "prof9.jpg")
    nd3.save(:validate => false)
    nd4 = Doctor.new(:username => "drEmily", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50, :years_in_practice => 14, :profile_pic => "prof8.jpg")
    nd4.save(:validate => false)
    nd5 = Doctor.new(:username => "drOneida", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40, :years_in_practice => 13, :profile_pic => "prof7.jpg")
    nd5.save(:validate => false)
    nd6 = Doctor.new(:username => "drThanh", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60, :years_in_practice => 12, :profile_pic => "prof6.jpg")
    nd6.save(:validate => false)
    nd7 = Doctor.new(:username => "drJ", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100, :years_in_practice => 17, :profile_pic => "prof5.jpg")
    nd7.save(:validate => false)
    nd8 = Doctor.new(:username => "drT", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70, :years_in_practice => 16, :profile_pic => "prof4.jpg")
    nd8.save(:validate => false)
    nd9 = Doctor.new(:username => "drA", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80, :years_in_practice => 15, :profile_pic => "prof3.jpg")
    nd9.save(:validate => false)
    nd10 = Doctor.new(:username => "drE", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50, :years_in_practice => 14, :profile_pic => "prof2.jpg")
    nd10.save(:validate => false)
    nd11 = Doctor.new(:username => "drO", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40, :years_in_practice => 13, :profile_pic => "prof1.jpg")
    nd11.save(:validate => false)
    nd12 = Doctor.new(:username => "drTh", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60, :years_in_practice => 12, :profile_pic => "prof11.jpg")
    nd12.save(:validate => false)
    nd13 = Doctor.new(:username => "drJohnE", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100, :years_in_practice => 17, :profile_pic => "prof11.jpg")
    nd13.save(:validate => false)
    nd14 = Doctor.new(:username => "drTannerr", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70, :years_in_practice => 16, :profile_pic => "prof10.jpg")
    nd14.save(:validate => false)
    nd15 = Doctor.new(:username => "drAbrahamS", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80, :years_in_practice => 15, :profile_pic => "prof9.jpg")
    nd15.save(:validate => false)
    nd16 = Doctor.new(:username => "drEmilyS", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50, :years_in_practice => 14, :profile_pic => "prof8.jpg")
    nd16.save(:validate => false)
    nd17 = Doctor.new(:username => "drOneidaR", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40, :years_in_practice => 13, :profile_pic => "prof7.jpg")
    nd17.save(:validate => false)
    nd18 = Doctor.new(:username => "drThanhN", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60, :years_in_practice => 12, :profile_pic => "prof6.jpg")
    nd18.save(:validate => false)

    for user in Doctor.all 
        salt = SecureRandom.hex
        user[:salt] = salt
        result = salt + user[:username]
        digest = Digest::SHA2.hexdigest(result)
        user[:encrypted_password] = digest
        user.save
    end



questions_list = [
  [ "Are superfoods a real thing?", "What should I buy at the grocery store to stay healthy? Which foods are superfoods?", "No such thing", "There are superfoods", "http://www.itslavida.com/files/2015/01/superfoods-1000x500.jpg", nu3.id],
  [ "Is gatorade better for you than water when exercising?", "What to do if I do an hour full body workout should what to do if i drink water or gatorade while i work out?", "Gatorade", "Water", "http://briangreen.net/files/2013/10/elixir-00-640x480.jpg", nu1.id],

  [ "Are supplements necessary to build muscle mass?", "Are supplements necessary to build muscle mass?", "Supplements are necessary to build muscle mass.", "Muscle mass can be built through exercise.", "http://cosmouk.cdnds.net/15/11/nrm_1425906239-pillsandsupplements.jpg", nu5.id],
  [ "Does lactic acid cause muscle soreness?", "I’ve heard lactic acid is caused by soreness. Is this true?", "Lactic acid causes delayed onset muscle soreness", "Delayed onset muscle soreness is a natural outcome of physical activity.", "http://www.bicyclestore.com.au/media/wysiwyg/LacticA.jpg", nu7.id],
  [ "Am I in good health if I have a good BMI reading?", "I received a good BMI rating last time at the doctors? Am I healthy?", "BMI should be used to evaluate good health.", "Waist circumference should be added to BMI to evaluate good health.", "http://www.apotheke-innsbruck.at/page/media/bmi.jpg", nu6.id],
  [ "Should eggs be a part of a healthy diet?", "Can I now eat eggs as a part of a healthy diet? ", "Eggs cause heart disease.", "Effect of egg consumption on blood cholesterol is minimal.", "https://moviewriternyu.files.wordpress.com/2013/10/eggs.jpg", nu1.id],
  [ "Should I be supplementing my diet with vitamin E?", "Does supplemental vitamin E protect against disease?", "Vitamin E protects against disease.", "Supplementing with Vitamin E may slightly lower lifespan.", "http://www.empoweringeverydaywomen.com/images/easter-eggs1000.jpg", nu9.id],
  [ "Does the idea that herbal supplements are natural mean they are safe?", "Can herbal supplements be taken like medicine?", "Herbal supplements are natural and good for you.", "Some herbal supplements cause liver toxicity.", "http://hairsupplements.org/wp-content/uploads/2014/03/HairSupplements1.jpg", nu2.id],
  [ "Will an antibiotic cure a cold?", "Why won’t my doctor give me an antibiotic for my cold?", "Antibiotics are for colds.", "Antibiotics should be used in the treatment of bacterial infections.", "http://www.pbiforum.net/images/cache/1000x500/crop/images%7Ccms-image-000000894.jpg", nu1.id],
  [ "Are ulcers caused by stress?", "Is it true that certain foods cause ulcers?", "Ulcers are caused by stress, food, and spices.", "Ulcers are caused by the bacteria Helicobacter pylori.", "http://indianparentsforum.com/home/wp-content/uploads/2015/03/how-to-deal-with-stress.jpg", nu3.id]
]

questions_list.each do |title, text, option1, option2, photo_link, normal_user_id|
  Question.create( title: title, text: text, option1: option1, option2: option2, photo_link: photo_link, normal_user_id: normal_user_id)
end


#Abraham Question
q11 = Question.create( title: "Should Prescription Drugs Be Advertised Directly to Consumers?", text: "The $300 billion a year US pharmaceutical industry spent $3.1 billion on advertising prescription drugs directly to consumers in 2012. [18] Since 1962 these ads have been regulated by the Food and Drug Administration (FDA) to ensure that they are not false or misleading.", option1: "Yes", option2: "No", photo_link: "https://neuroethicscanada.files.wordpress.com/2009/11/tv-drug-ads3.jpg?w=584", normal_user_id: nu4.id)

dv1 = DoctorVote.new(:optionNum => 1, :question_id => q11.id, :doctor_id => nd1.id)
dv1.save(:validate => false)
dv2 = DoctorVote.new(:optionNum => 2, :question_id => q11.id, :doctor_id => nd2.id)
dv2.save(:validate => false)
dv3 = DoctorVote.new(:optionNum => 1, :question_id => q11.id, :doctor_id => nd3.id)
dv3.save(:validate => false)
dv4 = DoctorVote.new(:optionNum => 1, :question_id => q11.id, :doctor_id => nd4.id)
dv4.save(:validate => false)
dv5 = DoctorVote.new(:optionNum => 1, :question_id => q11.id, :doctor_id => nd5.id)
dv5.save(:validate => false)
dv6 = DoctorVote.new(:optionNum => 1, :question_id => q11.id, :doctor_id => nd6.id)
dv6.save(:validate => false)

uv1 = UserVote.new(:optionNum => 1, :question_id => q11.id, :user_id => nu1.id)
uv1.save(:validate => false)
uv2 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu2.id)
uv2.save(:validate => false)
uv3 = UserVote.new(:optionNum => 1, :question_id => q11.id, :user_id => nu3.id)
uv3.save(:validate => false)
uv4 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu4.id)
uv4.save(:validate => false)
uv5 = UserVote.new(:optionNum => 1, :question_id => q11.id, :user_id => nu5.id)
uv5.save(:validate => false)
uv6 = UserVote.new(:optionNum => 1, :question_id => q11.id, :user_id => nu6.id)
uv6.save(:validate => false)
uv7 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu7.id)
uv7.save(:validate => false)
uv8 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu8.id)
uv8.save(:validate => false)
uv9 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu9.id)
uv9.save(:validate => false)
uv10 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu10.id)
uv10.save(:validate => false)
uv11 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu11.id)
uv11.save(:validate => false)
uv12 = UserVote.new(:optionNum => 2, :question_id => q11.id, :user_id => nu12.id)
uv12.save(:validate => false)

r1 = Response.new(:text => "Direct-to-consumer (DTC) prescription drug ads encourage people to seek medical advice from health professionals.64% of physicians surveyed in Apr. 2013 agreed that DTC ads encourage patients to contact a health professional. [42] A 2010 Prevention Magazine survey reported that 29 million patients talked to their doctors about a medical condition after seeing DTC prescription drug ads and most discussed behavioral and lifestyle changes; over half of those patients received non-prescription or generic drugs rather than the brand-name prescription drug seen in the ad, meaning that talking to the doctor was the real benefit. [32] Patients with lower incomes and education levels who are less likely to seek medical care in general were more likely to see a doctor after seeing DTC prescription drug ads. [44] A 2005 Journal of Family Practice article found that 83% of prescription drug print ads focused on patient-physician communication and 76% promoted dialogue with health care professionals. ", 
              :agreesNum => 0, 
              :doctor_id => nd1.id, 
              :is_doctor => 1, 
              :question_id => q11.id,
              :optionNum => 1)
r1.save(:validate => false)
r2 = Response.new(:text => "DTC prescription drug ads inform patients about diseases/medical conditions and possible treatments. 44% of patients responding to a 2007 survey published in Clinical Orthopaedics and Related Research said DTC prescription drug ads helped educate them about drugs, medical conditions, and treatments. [44] An Apr. 2013 FDA survey found that 48% of doctors agree that DTC ads inform, educate, and empower patients. [45] The FDA requires that benefits and risks of drugs be included in ads to inform patients. ", 
              :agreesNum => 0, 
              :doctor_id => nd2.id, 
              :is_doctor => 1, 
              :question_id => q11.id,
              :optionNum => 1)
r2.save(:validate => false)
r3 = Response.new(:text => """Direct-to-consumer (DTC) drug ads misinform patients. 63% of physicians surveyed in Apr. 2013 believed DTC prescription drug ads misinformed patients and 74% of physicians believed DTC prescription drug ads overemphasized the benefits of the drugs, resulting in misinformed patients. [42] According to a study published in the Sep. 2013 issue of Journal of General Internal Medicine, 60% of claims made in DTC prescription drug ads aired from 2008 to 2010 left out important information, exaggerated information, provided opinions, or made meaningless associations with lifestyles.""", 
      :agreesNum => 0, 
      :doctor_id => nd3.id,
      :is_doctor => 1, 
      :question_id => q11.id,
      :optionNum => 2)
r3.save
r4 = Response.new(:text => "Normal conditions and bodily functions are medicalized and stigmatized by DTC prescription drug ads. DTC prescription drug ads tell consumers that normal attributes, such as thinner eyelashes, or normal aging processes, such as lower testosterone levels and wrinkles, are medical conditions that need to be remedied with drugs. ", 
      :agreesNum => 0, 
      :doctor_id => nd4.id,
      :is_doctor => 1, 
      :question_id => q11.id,
      :optionNum => 2)
r4.save(:validate => false)


a1 = Agree.new(:response_id => r1.id, :voter_id => nu1.id, :is_doctor => 0, :vote_value => 1)
a1.save(:validate => false)
a2 = Agree.new(:response_id => r1.id, :voter_id => nd3.id, :is_doctor => 1, :vote_value => -1)
a2.save(:validate => false)
a3 = Agree.new(:response_id => r1.id, :voter_id => nu2.id, :is_doctor => 0, :vote_value => -1)
a3.save(:validate => false)
a4 = Agree.new(:response_id => r2.id, :voter_id => nu2.id, :is_doctor => 0, :vote_value => 1)
a4.save(:validate => false)
a5 = Agree.new(:response_id => r3.id, :voter_id => nu4.id, :is_doctor => 0, :vote_value => -1)
a5.save(:validate => false)
a6 = Agree.new(:response_id => r3.id, :voter_id => nu1.id, :is_doctor => 0, :vote_value => 1)
a6.save(:validate => false)

p1 = Paper.new(:optionNum => 1, :question_id => q11.id, :doctor_id => nd3.id, :url => "http://www.pharmedout.org/RxDrugMarketing.pdf", :img_path => 'pdf1.jpg')
p1.save(:validate => false)
p2 = Paper.new(:optionNum => 2, :question_id => q11.id, :doctor_id => nd4.id, :url => "http://ue.ucdavis.edu/explorations/2005/chiu.pdf", :img_path => 'pdf2.jpg')
p2.save(:validate => false)








