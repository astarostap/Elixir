class Question < ActiveRecord::Base
	has_many :responses
	has_many :doctor_votes
	has_many :user_votes
	belongs_to :user

	def query
		matching_questions = []
	
		for question in Question.all do
		
			isMatch = false;
			for t in photo.tags do 
				user = User.find(t.user_id)
				if (user.first_name.downcase.include?substr) or (user.last_name.downcase.include?substr) then
					isMatch = true;
				end
			end
			for comm in photo.comments do
				if comm.comment != nil and comm.comment.downcase.include? substr then
					isMatch = true;
				end
			end

			if isMatch then
				matching_photos << photo
			end
		
		end
		return matching_photos
	end

end
