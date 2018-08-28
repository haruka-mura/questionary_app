class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
  end

  def edit
  end

  def create
    @question = Question.new(question_params)
binding.pry
    if @question.save(@question, user: current_user.id)
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
  end

  private
    def set_question
      @question = question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:subject, :content, :state)
    end
end
