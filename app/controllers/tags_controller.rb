class TagsController < ApplicationController
  before_action :set_question, only: [:new, :create]

  def new
    @tag_form = TagForm.new
  end

  def edit
    @tags = Question.find(params[:id]).tags
    @tag_form = TagForm.new(question: Question.find(params[:id]))
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
    @tag_form = TagForm.new(tag_params.merge(question: Question.find(params[:id])))

    if @tag_form.save
      redirect_to @tag_form.question
    else
      render :edit
    end
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    def tag_params
      params.require(:tag_form).permit(:name)
    end
end
