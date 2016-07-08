class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # methods defined here will be available to all controllers
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
  # if we need methods to be available in view files we will need to add 'helper_method' and the first argument is the method name as a symbol.

  def current_question
    @current_question ||= Question.find params[:question_id]
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def sign_in(user)
    session[:user_id] = user.id
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in." unless user_signed_in?
  end

end
