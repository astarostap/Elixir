class Doctor < ActiveRecord::Base
	has_many :responses
	has_many :votes
	has_many :agrees
	has_many :questions
end
