class NormalUser < ActiveRecord::Base
	has_many :votes
	has_many :questions

	attr_accessor :password
  	# validates_formatting_of :email, :using => :email
  	# validates_length_of :password, :in => 6..20, :on => :create


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

		if try_digest == self.encrypted_password
			return true
		else
			return false
		end

	end
end
