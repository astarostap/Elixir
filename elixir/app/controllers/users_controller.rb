class UsersController < ApplicationController
	def new
    	@user = NormalUser.new 
  	end
  
  	def create
		f = params[:user]
		@new_user = NormalUser.new
		@new_user.password=(f[:password])
		@new_user.username = f[:username]
		@new_user.email = f[:email]
		if f[:password] != f[:password_confirmation] or params[:password] == ""
			flash.notice = "Passwords do not match. Please enter your password again."
			redirect_to :controller => "users", :id => @user_id, :action => "new"
		else
			@new_user.password=(f[:password])
			if @new_user.save
				#session[:id] = @new_user.id
				#session[:first_name] = @new_user.username
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
		if not User.find_by_login(f[:username]) 
			flash.notice = "Wrong username or password, try again!"
			redirect_to :controller => "users",  :action => "login"

		else
		
			@user = User.find_by_login(f[:username])

			if not @user.password_valid(f[:password])
				flash.notice = "Wrong login or password, try again!"
				redirect_to :controller => "users",  :action => "login"
			else
                #@user_id = @user.id
				#session[:id] = @user_id
				#session[:first_name] = @user.first_name
				#session[:last_name] = @user.last_name
				flash.notice = "Welcome " + @user.first_name + "!"
				redirect_to :controller => "users",  :action => "login"
			end

		end
	end
end
