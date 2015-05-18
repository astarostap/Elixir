class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :feeling_lucky

  def feeling_lucky
  	@all_questions = Question.all
  	@first, *@rest = @all_questions
  	@lucky_qstn = rand(1...@all_questions.length)
  	return @lucky_qstn
  end

end
