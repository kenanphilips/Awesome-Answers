class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    vote = Vote.new vote_params
    vote.user = current_user
    vote.question = current_question
    if vote.save
      redirect_to current_question
    else
      redirect_to current_question, alert: "An error occurred."
    end
  end

  def destroy
    vote = Vote.find_by_id params[:id]
    if vote
      vote.destroy
      redirect_to current_question
    else
      redirect_to current_question # case when vote has already been deleted
    end
  end

  def update
    vote = Vote.find params[:id]
    vote.update(vote_params)
    redirect_to current_question
  end

  private

  def vote_params
    params.require(:vote).permit(:is_up)
  end
end
