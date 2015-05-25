class UsersController < ApplicationController
	def new
    	@user = NormalUser.new 
  	end
  
  	def create
		f = params[:user]

		if f[:is_doctor]
			@new_user = Doctor.new
			@new_user.docScore = 80
			@new_user.specialty = f[:docSpecialty]
			@new_user.school = f[:docSchool]
			@new_user.knownFor = f[:knownFor]
			session[:is_doctor] = true
		else
			@new_user = NormalUser.new
			session[:is_doctor] = false
		end

		@new_user.password=(f[:password])
		@new_user.username = f[:username]
		@new_user.gender = f[:sex]
		@new_user.location = f[:origin]

		input_birthDay = f[:birth_date]
		split_bday = input_birthDay.split('/')
		@new_user.birth_date = DateTime.new(split_bday[2].to_i, split_bday[0].to_i, split_bday[1].to_i)

		puts "************"
		puts @new_user.inspect
		puts "*************"

		if f[:password] != f[:password_confirmation] or params[:password] == ""
			flash.notice = "Passwords do not match. Please enter your password again."
			redirect_to :controller => "users", :id => @user_id, :action => "new"
		else
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
