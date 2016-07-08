class QuestionsController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  before_action :authorize_owner, only: [:edit, :destroy, :update]
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
    respond_to do |format|
      format.html
      format.json { render json: {question: @question, answers: @question.answers} }
    end
  end

  def index
    @questions = Question.order(created_at: :desc).page(params[:page]).per(10)
    respond_to do |format|
      format.html
      format.json { render json: @questions }
    end
  end

  def edit
  end

  def update
    @question.slug = nil
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
    params.require(:question).permit(:title, :body, :category_id, {tag_ids: []})
  end

  def find_question
    @question = Question.friendly.find params[:id]
  end

  def authorize_owner
      redirect_to root_path, alert: "Access denied." unless can? :manage, @question
  end

  def current_user_vote
    @question.vote_for(current_user)
  end
  helper_method :current_user_vote

end
