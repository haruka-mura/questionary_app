class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update]
  before_action :set_question, only: [:index, :new, :edit, :update]

  # 後から消す
  def index
    @tags = Tag.all
  end

  # 後から消す
  def show
  end

  # タグが紐づいていなかったらnew
  def new
    @tag = Tag.new
  end

  # タグが紐づいてたらedit
  def edit
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      redirect_to question_tags_path, notice: 'Tag was successfully created.'
    else
      render :new
    end
  end

  def update
    if @tag.update(tag_params)
      redirect_to question_tags_path, notice: 'Question was successfully updated.'
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
      params.require(:tag).permit(:name)
    end
end
