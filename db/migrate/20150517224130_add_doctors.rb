class AddDoctors < ActiveRecord::Migration
  def change
  	jb = Doctor.new(:username => "drJohn", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100)
    jb.save(:validate => false)
    ph = Doctor.new(:username => "drTanner", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70)
    ph.save(:validate => false)
    mc = Doctor.new(:username => "drAbraham", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80)
    mc.save(:validate => false)
    bo = Doctor.new(:username => "drEmily", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50)
    bo.save(:validate => false)
    sc = Doctor.new(:username => "drOneida", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40)
    sc.save(:validate => false)
    jo = Doctor.new(:username => "drThanh", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60)
    jo.save(:validate => false)

    for user in Doctor.all 
  		salt = SecureRandom.hex
		user[:salt] = salt
		result = salt + user[:username]
		digest = Digest::SHA2.hexdigest(result)
		user[:encrypted_password] = digest
  		user.save
	end

  end
end