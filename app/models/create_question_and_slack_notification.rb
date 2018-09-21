class CreateQuestionAndSlackNotification
  include ActiveModel::Model
  include Rails.application.routes.url_helpers

  define_model_callbacks :save, only: :after
  attr_reader :question
  after_save :send_slack_notification

  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']

  def initialize(question)
    @question = question
  end

  def save
    run_callbacks :save do
      question.save
    end
  end

  private

    def send_slack_notification
      notifier = Slack::Notifier.new(WEBHOOK_URL)
      notifier.ping(slack_message)
    end

    def slack_message
      "新しい質問が投稿されました。URL：#{url_for([@question, only_path: false])}"
    end
end
