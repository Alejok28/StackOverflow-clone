class VotesController < ApplicationController
  before_action :authenticate_user!
  def create
    voteable = set_voteable
    route = set_route
    voteable.votes.create(user: current_user)
    redirect_to question_path(route)
  end

  def destroy
    voteable = set_voteable
    route = set_route
    voteable.votes.where(user: current_user).take.try(:destroy)
    redirect_to question_path(route)
  end

  private
  def set_voteable
    if params[:answer_id]
      voteable = Answer.find(params[:answer_id])
    elsif params[:question_id]
      voteable = Question.find(params[:question_id])
    end
  end
  def set_route
    if params[:answer_id]
      commentable = Answer.find(params[:answer_id])
      route = commentable.question
    elsif params[:question_id]
      commentable = Question.find(params[:question_id])
      route = commentable
    end
  end

end
