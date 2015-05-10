class QuestionsController < ApplicationController
	def index
		@all_questions = Question.all
		@first, *@rest = @all_questions
	end
end
