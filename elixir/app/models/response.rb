class Response < ActiveRecord::Base
	belongs_to :doctor
	has_many :agrees
end
