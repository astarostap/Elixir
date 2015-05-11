class Agree < ActiveRecord::Base
	belongs_to :response
	belongs_to :doctor
end
