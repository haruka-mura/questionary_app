class TagsController < ApplicationController
  before_action :set_question_from_id, only: [:edit, :update]

  def show
    @tag = Tag.find(params[:id])
  end

  def edit
    @tag_form = TagForm.new(question: @question)
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

    def set_question_from_id
      @question = Question.find(params[:id])
    end

    def tag_params
      params.require(:tag_form).permit(:name)
    end
end
