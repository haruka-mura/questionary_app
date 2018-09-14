class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update]


  def index
    @questions = question_search
    @keyword = keyword_params
  end

  def new
    @question = Question.new
  end

  def show
    @answers = @question.answers
    @tag_form = TagForm.new(question: @question)
  end

  def edit
  end

  def create
    @question = Question.new(question_params.merge(user: current_user))
    create_question_and_slack_notification = CreateQuestionAndSlackNotification.new(@question)

    if create_question_and_slack_notification.save
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

    def keyword_params
      params[:keyword]
    end

    def question_search
      keyword_params.nil? ? Question.all : Question.search_with_keyword(keyword_params)
    end

    def slack_message
      "新しい質問が投稿されました。URL：#{url_for([@question, only_path: false])}"
    end
end
