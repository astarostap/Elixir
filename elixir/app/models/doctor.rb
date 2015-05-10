class Doctor < ActiveRecord::Base
	has_many :responses
	has_many :votes
	has_many :agrees
	has_many :questions

	attr_accessor :password
  	validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  	validates_formatting_of :email, :using => :email
  	validates :password, :confirmation => true #password_confirmation attr
  	validates_length_of :password, :in => 6..20, :on => :create

  	def password
	end

	def password=(password)
		salt = SecureRandom.hex
		self[:salt] = salt
		result = salt + password
		digest = Digest::SHA2.hexdigest(result)
		self[:encrypted_password] = digest
	end

	def password_valid (password)

		try_result = salt + password
		try_digest = Digest::SHA2.hexdigest(try_result)

		if try_digest == self.:encrypted_password
			return true
		else
			return false
		end

	end
end
