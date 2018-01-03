class AnswersController < ApplicationController
  before_action :authenticate_user!
  def create
    question = Question.find(params[:question_id])
    comment = question.answers.create(answer_params)
    comment.user = current_user
    redirect_to question
  end

  private
    def answer_params
      params.require(:answer).permit(:body).merge(user: current_user)
    end
end
