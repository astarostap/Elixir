class Videos < ActiveRecord::Base
	belongs_to :question
	belongs_to :doctor
end
