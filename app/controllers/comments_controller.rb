class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    commentable = set_commentable
    comment = commentable.comments.create(comment_params)
    comment.user = current_user
    route = set_route
    redirect_to question_path(route)
  end

  private
    def set_commentable
      if params[:answer_id]
        commentable = Answer.find(params[:answer_id])
      elsif params[:question_id]
        commentable = Question.find(params[:question_id])
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

    def comment_params
      params.require(:comment).permit(:body).merge(user: current_user)
    end
end
