class Question < ActiveRecord::Base
	has_many :responses
	has_many :doctor_votes
	has_many :user_votes
	has_many :papers
	belongs_to :user

	def getQueries (substr)
		matching_questions = []
	
		for question in Question.all do
		
			isMatch = false;
			if((question.title.downcase.include?substr) or 
				(question.text.downcase.include?substr) or
				(question.option1.downcase.include?substr) or
				(question.option2.downcase.include?substr))
				then
					isMatch = true;
			end

			if isMatch then
				matching_questions << question
			end
		
		end
		return matching_questions
	end

end
