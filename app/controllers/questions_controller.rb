class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update]


  def index
    @questions = Question.all
    @search_form = Question.search(keyword)
  end

  def new
    @question = Question.new
  end

  def show
    @answers = @question.answers
  end

  def edit
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:subject, :content, :state)
    end

    def keyword
      binding.pry
      params[:keyword]
    end
end
