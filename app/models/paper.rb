class Paper < ActiveRecord::Base
	belongs_to :question
	belongs_to :doctors
end
