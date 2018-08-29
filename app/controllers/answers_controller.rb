class AnswersController < ApplicationController
  before_action :set_question, only: :create
  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params.merge(question: @question, user: current_user))

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  private
    def set_question
      @question = Question.find(params[:question_id])
    end

    def answer_params
      params.require(:answer).permit(:comment)
    end
end
