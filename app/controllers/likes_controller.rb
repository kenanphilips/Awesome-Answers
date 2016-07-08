class LikesController < ApplicationController
  # skip_before_action :authenticate_user! - use this if you have a feature that anyone can access.
  before_action :authenticate_user!

  def index
    @questions = current_user.liked_questions
  end

  def create
    question = Question.find params[:question_id]
    l        = Like.new(question: question, user: current_user)
    if l.save
      redirect_to question_path(question)
    else
      redirect_to question_path(question)
    end
  end

  def destroy
    like     = Like.find params[:id]
    question = Question.find params[:question_id]
    like.destroy if can? :destroy, Like
    redirect_to question_path(question)
  end

end
