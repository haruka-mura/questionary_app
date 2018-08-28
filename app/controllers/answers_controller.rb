class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user
    @answer.question = Question.find(params[:question_id])

    if @answer.save
      redirect_to @answer.question
    else
      render :new
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:comment)
    end
end
