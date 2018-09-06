class TagsController < ApplicationController
  before_action :set_question_from_question_id, only: [:new, :create]
  before_action :set_question_from_id, only: [:edit, :update]

  def new
    @tag_form = TagForm.new
  end

  def edit
    @tags = @question.tags
    @tag_form = TagForm.new(question: @question)
  end

  def create
    @tag_form = TagForm.new(tag_params.merge(question: @question))

    if @tag_form.save
      redirect_to @tag_form.question
    else
      render :new
    end
  end

  def update
    @tag_form = TagForm.new(tag_params.merge(question: @question))

    if @tag_form.save
      redirect_to @tag_form.question
    else
      render :edit
    end
  end

  private

    def set_question_from_question_id
      @question = Question.find(params[:question_id])
    end

    def set_question_from_id
      @question = Question.find(params[:id])
    end

    def tag_params
      params.require(:tag_form).permit(:name)
    end
end
