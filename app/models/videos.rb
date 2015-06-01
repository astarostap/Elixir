class Videos < ActiveRecord::Base
	validates :url, presence: true
	validates :optionNum, presence: true
	validates :title, presence: true

	belongs_to :question
	belongs_to :doctor
end