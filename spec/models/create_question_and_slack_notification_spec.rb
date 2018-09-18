require 'rails_helper'

RSpec.describe CreateQuestionAndSlackNotification, type: :model do
  describe '#save' do
    subject { slack_notification.save }
    let(:question) { build :question }
    let(:slack_notification) { CreateQuestionAndSlackNotification.new(question) }
    let(:slack_notification_instance) { instance_double Slack::Notifier }

    before { allow(Slack::Notifier).to receive(:new).and_return(slack_notification_instance) }

    context 'slack通知が成功するとき' do
      before { allow(slack_notification_instance).to receive(:ping).and_return(true) }
      it { is_expected.to be_truthy }
    end

    context 'slack通知が失敗するとき' do
      before { allow(slack_notification_instance).to receive(:ping).and_return(false) }
      it { is_expected.to be_truthy }
    end
  end
end
