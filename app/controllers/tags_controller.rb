class TagsController < ApplicationController
  before_action :set_tag, only: :show
  before_action :set_question, only: [:index, :new, :edit, :create, :show]

  # 後から消す
  def index
    @tags = Tag.all
  end

  # 後から消す
  def show
  end

  # タグが紐づいていなかったらnew
  def new
    @tag_form = TagForm.new
  end

  # タグが紐づいてたらedit
  def edit
    @tags = @question.tags
    @tag_form = TagForm.new(question: @question)
  end

  def create
    @tag_form = TagForm.new(tag_params.merge(question: @question))
    # @question.tags << @tag

    if @tag_form.save
      redirect_to @tag_form.question, notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  def update
    @tag_form = TagForm.new(tag_params.merge(question: Question.find(params[:id])))

    if @tag_form.update
      redirect_to @tag_form.question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  private

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag_form).permit(:name)
    end
end
