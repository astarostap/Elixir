class QuestionsController < ApplicationController
	def show
		session[:qid] = params[:id]
		@qid = session[:qid]
		@active_question = Question.find(params[:id])

		puts "************************"
		@active_question.user_votes.each do |v| 
			puts v.user_id
		end

		puts "************************"
		#text = "omg this is a really long and interesting question and I love pie so much. God I wish I had some pie right now, I would be so happy...."
		#o1 = "this is a really long option 1 but I want to test if it wraps correctly. I'm just going to keep writing until something really big and stupid happens to my poor comment space. Abraham is a douche; look at him wearing that stupid leather jacket. And a pocket on his T-shirt? What a nerd..." 
		
		@comments = [["test", "o1c2"], ["o2c1", "02c2", "02c3", "02c4"]]
		#@question = Question.new(:title => "Title", 
		#						 :text => text, 
		#						 :option1 => o1, 
		#						 :option2 => "Option 2")
	end

	def index
		@all_questions = Question.all
  		@first, *@rest = @all_questions
	end

	def create_comment
		puts "******************************************************************"
		puts params
		puts "*****************************************************"
		@comment = Response.new
		@comment.text = params[:text]
		@comment.
		    t.integer  "agreesNum"
		puts "*****************"
		puts @comment.inspect
		puts "**************"
		@comment.save
		render nothing: true
	end

	def show_paper
		q = params[:question_id]
		@paper = Paper.find(q)
	end

	def create_paper
		p = params[:paper]
		@paper = Paper.new
		@paper.optionNum = p[:optionNum].to_i
		@paper.doctor_id = session[:id]
		@paper.question_id = p[:question_id]
		@paper.url = p[:url]
		@paper.save
		redirect_to :controller => "questions", :id => p[:question_id].to_i, :action => "show"
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

	def option_vote
		puts "*********"
		puts session[:is_doctor]
		puts "*********"
		if(session[:id])
			if(session[:is_doctor]) 
				DoctorVote.create(:optionNum => params[:option],
								  :doctor_id => session[:id],
								  :question_id => session[:qid])
			else
				UserVote.create(:optionNum => params[:option],
								:user_id => session[:id],
								:question_id => session[:qid])
			end
		end
		render nothing: true
	end

	def query_votes
		puts "here---------------------------"
		q = Question.find(session[:qid])
		user_content = "["
		q.user_votes.each do |v|
			user_content += '{"option":' + v.optionNum.to_s + '},'

			#user = User.find(v.user_id)

			#now = Time.now.utc.to_date
			#dob = user.birth_date
  			#age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)

			#user_content += '{"age":'' + age + "," +
			#			     '"location":' + user.location + "," +
			#				 '"gender":' + user.gender + "," +
			#				 'option":' + v.optionNum + "},"
		end
		user_content = user_content[0..(user_content.length - 2)] + "]"

		content = '{"users":' + user_content + "}"
		render :json => content
	end
end
