class UserVote < ActiveRecord::Base
	belongs_to :question
end
