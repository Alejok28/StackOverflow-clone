class QuestionsController < ApplicationController
  before_action :authenticate_user!,  except: [:index, :show]
  def index
    @questions = Question.order(created_at: :desc).where("title like ?", "%#{params[:title]}%")
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user =current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :body, :user_id)
    end
end
