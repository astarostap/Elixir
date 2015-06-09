class QuestionsController < ApplicationController
	def show
		session[:qid] = params[:id]
		@qid = session[:qid]
		@active_question = Question.find(params[:id])
		@docs = [[], []]
		@active_question.doctor_votes.each do |v|
			doctor = Doctor.find(v.doctor_id)
			index = (v.optionNum == 1) ? 0 : 1;
			doc_info = {
				username: doctor.username,
				specialty: doctor.specialty,
				pic: doctor.profile_pic,
				rating: doctor.docScore,
				doc_id: doctor.id,
				resp_id: []
			}

			for i in 0..@docs[index].length
				if(i == @docs[index].length)
					@docs[index].push(doc_info)
					break
				elsif(doc_info[:rating] > @docs[index][i][:rating]) 
					@docs[index].insert(i, doc_info);
					break
				end
			end
		end

		@comments = [[], []]
		@active_question.responses.each do |r|
			if(r.is_doctor)
				user = Doctor.find(r.doctor_id)

				[0, 1].each do |i|

					@docs[i].each do |doc|
						if(doc[:doc_id] == user.id)
							doc[:resp_id] << r.id
							break
						end
					end

				end
			else
				user = NormalUser.find(r.user_id)
			end

			agrees = 0
			r.agrees.each do |a|
				agrees += a.vote_value
			end

			response = {
				username: user.username,
				text: r.text,
				agrees: agrees,
				pic: user.profile_pic,
				id: r.id
			}
			@comments[r.optionNum - 1].push(response)
		end

		puts @docs[1]

		allvidsone = []
		allvidstwo = []
		for v in Videos.all do
			if v.question_id == @active_question.id then
				if v.optionNum == 1 then
					allvidsone << v
				else
					allvidstwo << v
				end
			end
		end


		@vids_left = []
		if allvidsone.count > allvidstwo.count then
			@vid_pairs= allvidstwo.zip(allvidsone)
			@vids_left = allvidsone[allvidstwo.count, allvidsone.count]
			@vids_opt_left = 1
		else
			@vid_pairs= allvidsone.zip(allvidstwo)
			@vids_left = allvidstwo[allvidsone.count, allvidstwo.count]
			@vids_opt_left = 2
		end
	end

	def index
		@all_questions = Question.all.shuffle
  		@first, *@rest = @all_questions
	end

	def create_comment
		@comment = Response.new
		@comment.text = params[:text]
		@comment.is_doctor = session[:is_doctor]
		@comment.question_id = session[:qid]
		@comment.agreesNum = 0
		@comment.optionNum = params[:option]
		if session[:is_doctor]
			@comment.doctor_id = session[:id]
		else
			@comment.user_id = session[:id]
		end
		@comment.save

		render json: @comment.id
	end


	def create_agree
		@agree = Agree.new
		@agree.response_id = params[:response_id]
		@agree.is_doctor = session[:is_doctor]
		@agree.voter_id = session[:id]
		@agree.vote_value = params[:vote].to_i
		@agree.save
		render nothing: true
	end

	def create_video
		p = params[:video]
		@video = Videos.new
		@video.title = p[:title]
		@video.question_id = p[:question_id]
		@video.optionNum = p[:optionNum]
		@video.url = p[:url]
		if not @video.save
			flash.notice = "You didn't enter one of the fields!"
			redirect_to :controller => "questions", :id => p[:question_id].to_i, :action => "show"
		else
			redirect_to :controller => "questions", :id => p[:question_id].to_i, :action => "show"
		end
		
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
		@paper.title = p[:title]
		puts "**************"
		puts @paper.inspect
		puts "**************"
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


		@new_question.photo_link =  params[:picture].original_filename

		@pic_file = params[:picture]
		File.open(Rails.root.join('app/assets', 'images', params[:picture].original_filename), 'wb') do |f|
			f.write(@pic_file.read)
		end

		if not @new_question.save
			flash.notice = "You didn't enter one of the fields!"
			redirect_to :controller => "questions", :action => "new"
		else
			redirect_to :controller => "questions", :id => @new_question.id, :action => "show"
		end

	end

	def option_vote
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
		q = Question.find(session[:qid])


		user_content = "[ "
		q.user_votes.each do |v|

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

		user_content = user_content[0..(user_content.length - 2)] + "]"

		doc_content = "[ "
		q.doctor_votes.each do |v|
			doc = Doctor.find(v.doctor_id)

			doc_content += '{"specialty":"' + doc.specialty + '",' +
						    '"YIP":"' + doc.years_in_practice.to_s + '",' +
							'"rating":"' + doc.docScore.to_s + '",' +
							'"option":"' + v.optionNum.to_s + '",' +
							'"id":"' + v.doctor_id.to_s + '"},'
		end
		doc_content = doc_content[0..(doc_content.length - 2)] + "]"

		votes = '{"user":' + user_content + ', "doctor":' + doc_content + "}"

		type = session[:is_doctor] ? "doctor" : "user"
		if(session[:id])
			user_votes = "[ "
			comment_votes = Agree.where(voter_id: session[:id])

			comment_votes.each do |v|
				user_votes += v.response_id.to_s + ","
			end
			user_votes = user_votes[0..(user_votes.length - 2)] + "]"
			puts user_votes
			current_user = '{"id":' + session[:id].to_s + 
						  ', "type":"' + type + 
						 '", "votes":' + user_votes + 
						 ', "username":"' + session[:username] + '"}'
			puts current_user
		else
			current_user = "null"
		end

		content = '{"curr":' + current_user + ', "votes":' + votes + "}"
		render :json => content
	end
end
