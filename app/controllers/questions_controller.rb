class QuestionsController < ApplicationController
	def show
		session[:qid] = params[:id]
		@qid = session[:qid]
		@active_question = Question.find(params[:id])

		@docs = [[], []];
		@active_question.doctor_votes.each do |v|
			doctor = Doctor.find(v.doctor_id)
			index = (v.optionNum == 1) ? 0 : 1;
			for i in 0..@docs[index].length
				if(i == @docs[index].length || doctor.docScore > @docs[index][i].docScore) 
					@docs[index].push(doctor);
				end
			end
		end

		puts @docs

		@comments = [["test", "o1c2"], ["o2c1", "02c2", "02c3", "02c4"]]
	end

	def index
		@all_questions = Question.all.shuffle
  		@first, *@rest = @all_questions
	end

	def create_comment
		@comment = Response.new
		@comment.text = params[:text]
<<<<<<< HEAD
		@comment.is_doctor = session[:is_doctor]
		if session[:is_doctor]
			@comment.doctor_id = session[:id]
		else
			@comment.user_id = session[:id]
		end
=======
		puts "*****************"
>>>>>>> johnCasa
		puts @comment.inspect
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
		val = 1
		q.user_votes.each do |v|
			val = 2
			puts "********************************************************"
			puts v
			puts v.user_id
			puts "********************************************************"

			user = NormalUser.find(v.user_id)

			now = Time.now.utc.to_date
			dob = user.birth_date
  			age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)

			user_content += '{"age":"' + age.to_s + '",' +
						     '"location":"' + user.location + '",' +
							 '"gender":"' + user.gender + '",' +
							 '"option":"' + v.optionNum.to_s + '",' +
							 '"id":"' + v.user_id.to_s + '"},'
		end

		user_content = user_content[0..(user_content.length - val)] + "]"

		val = 1
		doc_content = "["
		q.doctor_votes.each do |v|
			val = 2
			doc = Doctor.find(v.doctor_id)

			doc_content += '{"specialty":"' + doc.specialty + '",' +
						    '"YIP":"' + 10.to_s + '",' +
							'"rating":"' + doc.docScore.to_s + '",' +
							'"option":"' + v.optionNum.to_s + '",' +
							'"id":"' + v.doctor_id.to_s + '"},'
		end
		doc_content = doc_content[0..(doc_content.length - val)] + "]"

		votes = '{"user":' + user_content + ', "doctor":' + doc_content + "}"

		type = session[:is_doctor] ? "doctor" : "user"
		current_user = '{"id":' + session[:id].to_s + ', "type":"' + type + '"}'
		content = '{"curr":' + current_user + ', "votes":' + votes + "}"
		puts "********************************************************"
		puts content
		puts "********************************************************"
		render :json => content
	end
end
