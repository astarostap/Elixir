class Paper < ActiveRecord::Base
	belongs_to :question
	belongs_to :doctor
end
