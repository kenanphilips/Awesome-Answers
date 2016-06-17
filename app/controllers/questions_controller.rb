class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @question = Question.new
  end

  def create
    @question      = Question.new question_params
    @question.user = current_user
    if @question.save
      # redirect_to question_path({id: @question.id})
      # render :show
      # flash[:notice] = "Question created!"
      redirect_to question_path(@question), notice: "Question created!"
    else
      flash[:alert] = "Question not created!"
      render :new
    end
  end

  def show
    @question.increment!(:view_count)
    @answer = Answer.new
  end

  def index
    @questions = Question.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question), notice: "Question updated"
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Question deleted"
  end

private

  def question_params
    # In the line below we're using the 'strong parameters' feature of Rails
    # In the line we're "requiring" that the "params" hash has a key
    # called question and we're only allowing the 'title' and the 'body' to be fetched.
    params.require(:question).permit(:title, :body, :category_id)
  end

  def find_question
    @question = Question.find params[:id]
  end

  def authenticate_user!
    redirect_to new_session_path, alert: "Please sign in." unless user_signed_in?
  end
end
