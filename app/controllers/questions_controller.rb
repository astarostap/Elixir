class QuestionsController < ApplicationController
	def show
		/q_id = params[:qid]
		@active_question = questions.find(q_id)/
		text = "omg this is a really long and interesting question and I love pie so much. God I wish I had some pie right now, I would be so happy...."
		o1 = "this is a really long option 1 but I want to test if it wraps correctly"
		@question = Question.new(:title => "Title", :text => text, :option1 => o1, :option2 => "Option 2")
	end

	def index
		@all_questions = Question.all
		@first, *@rest = @all_questions
		lucky_qstn = rand(1...@all_questions.length)
		@lucky_href = "/questions/" + lucky_qstn.to_s
	end

	def query
		@result = []
		if params[:query] == nil then
			render :list_results
		else
			substr = params[:query].downcase
			q = Question.new
			findings = q.getQueries(substr)
			for question in findings do
				@result << question
			end
			render :list_results
		end
	end

	def new
		@question = Question.new
	end

	def create
		q = params[:question]
		@new_question = Question.new
		@new_question.title = q[:title]
		@new_question.text = q[:text]
		@new_question.option1 = q[:option1]
		@new_question.option2 = q[:option2]
		@new_question.photo_link = q[:photo_link]

		@new_question.save
		redirect_to :controller => "questions", :id => @new_question.id, :action => "show"
	end

end
