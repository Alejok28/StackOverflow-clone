class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def show
    @questions = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

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
