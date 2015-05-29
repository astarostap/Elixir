class AddDoctors < ActiveRecord::Migration
  def change
  	jb = Doctor.new(:username => "drJohn", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100, :years_in_practice => 17, :profile_pic => "prof11.jpg")
    jb.save(:validate => false)
    ph = Doctor.new(:username => "drTanner", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70, :years_in_practice => 16, :profile_pic => "prof10.jpg")
    ph.save(:validate => false)
    mc = Doctor.new(:username => "drAbraham", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80, :years_in_practice => 15, :profile_pic => "prof9.jpg")
    mc.save(:validate => false)
    bo = Doctor.new(:username => "drEmily", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50, :years_in_practice => 14, :profile_pic => "prof8.jpg")
    bo.save(:validate => false)
    sc = Doctor.new(:username => "drOneida", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40, :years_in_practice => 13, :profile_pic => "prof7.jpg")
    sc.save(:validate => false)
    jo = Doctor.new(:username => "drThanh", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60, :years_in_practice => 12, :profile_pic => "prof6.jpg")
    jo.save(:validate => false)
    jb = Doctor.new(:username => "drJ", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100, :years_in_practice => 17, :profile_pic => "prof5.jpg")
    jb.save(:validate => false)
    ph = Doctor.new(:username => "drT", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70, :years_in_practice => 16, :profile_pic => "prof4.jpg")
    ph.save(:validate => false)
    mc = Doctor.new(:username => "drA", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80, :years_in_practice => 15, :profile_pic => "prof3.jpg")
    mc.save(:validate => false)
    bo = Doctor.new(:username => "drE", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50, :years_in_practice => 14, :profile_pic => "prof2.jpg")
    bo.save(:validate => false)
    sc = Doctor.new(:username => "drO", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40, :years_in_practice => 13, :profile_pic => "prof1.jpg")
    sc.save(:validate => false)
    jo = Doctor.new(:username => "drTh", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60, :years_in_practice => 12, :profile_pic => "prof11.jpg")
    jo.save(:validate => false)
    jb = Doctor.new(:username => "drJohnE", :email => "jpekins@gmail.com", :specialty => "Pediatrics", :knownFor => "Child Nutrition", :school => "UC Irvine School of Medicine", :docScore => 100, :years_in_practice => 17, :profile_pic => "prof11.jpg")
    jb.save(:validate => false)
    ph = Doctor.new(:username => "drTannerr", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Chest Pain", :school => "Stanford School of Medicine", :docScore => 70, :years_in_practice => 16, :profile_pic => "prof10.jpg")
    ph.save(:validate => false)
    mc = Doctor.new(:username => "drAbrahamS", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Diabetes", :school => "Ross University School of Medicine", :docScore => 80, :years_in_practice => 15, :profile_pic => "prof9.jpg")
    mc.save(:validate => false)
    bo = Doctor.new(:username => "drEmilyS", :email => "fake@fake.com", :specialty => "Obstetrics and Gynecology", :knownFor => "Hysteroscopy", :school => "University of Colorado Denver School of Medicine", :docScore => 50, :years_in_practice => 14, :profile_pic => "prof8.jpg")
    bo.save(:validate => false)
    sc = Doctor.new(:username => "drOneidaR", :email => "fake@fake.com", :specialty => "Internal Medicine", :knownFor => "Female Health", :school => "Duke University School of Medicine", :docScore => 40, :years_in_practice => 13, :profile_pic => "prof7.jpg")
    sc.save(:validate => false)
    jo = Doctor.new(:username => "drThanhN", :email => "fake@fake.com", :specialty => "Pediatrics", :knownFor => "Child Surgery", :school => "UC Berkeley School of Medicine", :docScore => 60, :years_in_practice => 12, :profile_pic => "prof6.jpg")
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