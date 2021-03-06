class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question,only:[:create,:destroy]

  
  def create
    # /questions/:question_id/answers(.:format) ðð» Route for quick reference
    # @question=Question.find params[:question_id] # question_id comming from ðð»URL
    
    @answer=Answer.new answer_params
    @answer.question=@question
    @answer.user=current_user
    if @answer.save
      # AnswerMailer.new_answer(@answer).deliver_now
      # AnswerMailer.new_answer(@answer).deliver_later
      AnswerMailer.delay(run_at: 1.minutes.from_now).new_answer(@answer)
      redirect_to question_path(@question), notice: 'Answer created'
    else 
      @answers=@question.answers.order(created_at: :desc)
      render '/questions/show'
    end
  end
  def destroy
    # /questions/:question_id/answers/:id
    # @question=Question.find params[:question_id]
    @answer=Answer.find params[:id]
    if can?(:crud,@answer)
      @answer.destroy
      redirect_to question_path(@question), notice: 'Answer Deleted!'
    else
      # head :unauthorized
      redirect_to root_path, alert:'Not Authorized!'
    end
  end
  private
  def find_question
    @question=Question.find params[:question_id]
  end
  def answer_params
    params.require(:answer).permit(:body)
  end
  
end
