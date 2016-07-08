class AnswersController < ApplicationController

  def create
    @answer          = Answer.new answer_params
    @question        = Question.find params[:question_id]
    @answer.question = @question

    respond_to do |format|

      if @answer.save
        AnswersMailer.notify_question_owner(@answer).deliver_later

        format.html { redirect_to question_path(@question), notice: "Answer created!" }
        # format.js { render js: "alert('Does this browser support JS?');" }
        format.js { render :create_success } # will look for file in view called answers/create_success.js.erb

      else
        format.html { render "/questions/show" }
        format.js { render :create_failure }
        # will look for file in views called answers/create_failure.js.erb
      end
    end
  end

  def destroy
    question = Question.find params[:question_id]
    @answer   = Answer.find params[:id]
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to question_path(question), notice: "Answer deleted." }
      # format.js { render :destroy_success }
      format.js { render } # render /app/views/answers/destroy.js.erb
    end

  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
