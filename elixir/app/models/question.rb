class Question < ActiveRecord::Base
	has_many :responses
	has_many :doctor_votes
	has_many :user_votes
	belongs_to :user
end
