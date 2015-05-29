class AddUsers < ActiveRecord::Migration
  def change
  	jb = NormalUser.new(:username => "John", :email => "jpekins@gmail.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Western U.S.", :profile_pic => "prof1.jpg")
    jb.save(:validate => false)
    ph = NormalUser.new(:username => "Tanner", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Western U.S.", :profile_pic => "prof2.jpg")
    ph.save(:validate => false)
    mc = NormalUser.new(:username => "Abraham", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Southern U.S.", :profile_pic => "prof3.jpg")
    mc.save(:validate => false)
    bo = NormalUser.new(:username => "Emily", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Midwest U.S.", :profile_pic => "prof4.jpg")
    bo.save(:validate => false)
    sc = NormalUser.new(:username => "Oneida", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Western U.S.", :profile_pic => "prof5.jpg")
    sc.save(:validate => false)
    jo = NormalUser.new(:username => "Thanh", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Midwest U.S.", :profile_pic => "prof6.jpg")
    jo.save(:validate => false)
    jb = NormalUser.new(:username => "Abe", :email => "jpekins@gmail.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Eastern U.S.", :profile_pic => "prof7.jpg")
    jb.save(:validate => false)
    ph = NormalUser.new(:username => "Morgan", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Western U.S.", :profile_pic => "prof8.jpg")
    ph.save(:validate => false)
    mc = NormalUser.new(:username => "Oracle", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Southern U.S.", :profile_pic => "prof9.jpg")
    mc.save(:validate => false)
    bo = NormalUser.new(:username => "Linux", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Midwest U.S.", :profile_pic => "prof10.jpg")
    bo.save(:validate => false)
    sc = NormalUser.new(:username => "HP", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "female", :location => "Eastern U.S.", :profile_pic => "prof11.jpg")
    sc.save(:validate => false)
    jo = NormalUser.new(:username => "Costco", :email => "fake@fake.com", :birth_date => DateTime.new(1986, 9, 16), :gender => "male", :location => "Midwest U.S.", :profile_pic => "prof1.jpg")
    jo.save(:validate => false)

    for user in NormalUser.all
  		salt = SecureRandom.hex
		user[:salt] = salt
		result = salt + user[:username]
		digest = Digest::SHA2.hexdigest(result)
		user[:encrypted_password] = digest
  		user.save
	end
  end
end
