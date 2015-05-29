class AddUsers < ActiveRecord::Migration
  def change
  	jb = NormalUser.new(:username => "John", :email => "jpekins@gmail.com", :birth_date => DateTime.new(1, 1, 1), :gender => "male", :location => "west")
    jb.save(:validate => false)
    ph = NormalUser.new(:username => "Tanner", :email => "fake@fake.com", :birth_date => DateTime.new(1, 1, 1), :gender => "male", :location => "west")
    ph.save(:validate => false)
    mc = NormalUser.new(:username => "Abraham", :email => "fake@fake.com", :birth_date => DateTime.new(1, 1, 1), :gender => "male", :location => "east")
    mc.save(:validate => false)
    bo = NormalUser.new(:username => "Emily", :email => "fake@fake.com", :birth_date => DateTime.new(1, 1, 1), :gender => "female", :location => "midwest")
    bo.save(:validate => false)
    sc = NormalUser.new(:username => "Oneida", :email => "fake@fake.com", :birth_date => DateTime.new(1, 1, 1), :gender => "female", :location => "west")
    sc.save(:validate => false)
    jo = NormalUser.new(:username => "Thanh", :email => "fake@fake.com", :birth_date => DateTime.new(1, 1, 1), :gender => "male", :location => "midwest")
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