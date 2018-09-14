require 'rails_helper'

RSpec.describe CreateQuestionAndSlackNotification, type: :model do
  describe '#save' do
    subject { CreateQuestionAndSlackNotification.new(question).save }
    let(:question) { build :question }
    let(:slack_notification_mock) { instance_double CreateQuestionAndSlackNotification }
    let(:slack_notification) { CreateQuestionAndSlackNotification.new(question) }

    before do
      # slack_notification = CreateQuestionAndSlackNotification.new
      # allow_any_instance_of(slack_notification).to receive(:save).and_return(true)
      allow(slack_notification).to receive(:send_slack_notification).and_return(slack_notification_mock)
    end

    it 'saveが成功する' do
      is_expected.to be_truthy
    end
  end
end
