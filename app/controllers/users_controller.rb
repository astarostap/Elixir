class UsersController < ApplicationController
	def new
    	@user = NormalUser.new 
  	end
  
  	def create
		f = params[:user]

		problems = false
		if f[:is_doctor]
			@new_user = Doctor.new
			if f[:docSpecialty] == "" or f[:docSchool] == "" or f[:years_in_practice] == "" then
				problems = true
			else
				@new_user.docScore = 80
				@new_user.specialty = f[:docSpecialty]
				@new_user.school = f[:docSchool]
				@new_user.years_in_practice = f[:years_in_practice]
				session[:is_doctor] = true
			end
		else
			@new_user = NormalUser.new
			session[:is_doctor] = false
		end

		@new_user.password=(f[:password])
		@new_user.username = f[:username]
		@new_user.gender = f[:sex]
		@new_user.location = f[:origin]
		@new_user.profile_pic = f[:username] + ".jpg"

		puts "************"
		puts @new_user.inspect
		puts "*************"


		if problems or f[:password] != f[:password_confirmation] or params[:password] == "" or f[:username] == "" or f[:origin] == "" or f[:sex] == "" or f[:birth_date] == "" or f[:password] == "" or f[:password_confirmation] == ""
			flash.notice = "Please fill out the form completely. Thank you."
			redirect_to :controller => "users", :id => @user_id, :action => "new"
		else
			@pic_file = params[:picture]
			File.open(Rails.root.join('app/assets', 'images', f[:username] + ".jpg"), 'wb') do |f|
				f.write(@pic_file.read)
			end
			input_birthDay = f[:birth_date]
			split_bday = input_birthDay.split('/')
			@new_user.birth_date = DateTime.new(split_bday[2].to_i, split_bday[0].to_i, split_bday[1].to_i)
			@new_user.password=(f[:password])
			if @new_user.save
				session[:id] = @new_user.id
				session[:username] = @new_user.username
				flash.notice = "Welcome " + @new_user.username + "!"
				redirect_to :controller => "questions"
			else
				flash.notice = "Didn't save the user"
				redirect_to :controller => "users", :id => @user_id, :action => "new"
			end
		end
  	end

  	def login
	end

	def post_login
		f = params[:user]
		if not f[:is_doctor]
			if not NormalUser.find_by_username(f[:username]) 
				flash.notice = "Wrong username or password, try again!"
				redirect_to :controller => "users",  :action => "login"

			else
				@user = NormalUser.find_by_username(f[:username])
				if not @user.password_valid(f[:password])
					flash.notice = "Wrong username or password, try again!"
					redirect_to :controller => "users",  :action => "login"
				else
               		@user_id = @user.id
					session[:id] = @user_id
					session[:username] = @user.username
					session[:is_doctor] = false
					flash.notice = "Welcome " + @user.username + "!"
					redirect_to :controller => "questions"
				end

			end
		else
			if not Doctor.find_by_username(f[:username]) 
				flash.notice = "Wrong username or password, try again!"
				redirect_to :controller => "users",  :action => "login"

			else
				@user = Doctor.find_by_username(f[:username])
				if not @user.password_valid(f[:password])
					flash.notice = "Wrong username or password, try again!"
					redirect_to :controller => "users",  :action => "login"
				else
               		@user_id = @user.id
					session[:id] = @user_id
					session[:username] = @user.username
					session[:is_doctor] = true
					flash.notice = "Welcome " + @user.username + "!"
					redirect_to :controller => "questions"
				end

			end
		end
	end

	def logout
		reset_session
		flash.notice = "You have logged out. See you soon!"
		redirect_to :controller => "users", :action => "login"
	end
end
