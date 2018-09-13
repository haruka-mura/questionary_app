require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe '#login' do
    subject { proc { helper.log_in(user) } }

    let(:user) { create(:user) }

    it { is_expected.to change { session[:user_id] }.from(nil).to(user.id) }
  end

  describe '#log_out' do
    subject { proc { helper.log_out } }

    let(:user) { create(:user) }

    before { helper.log_in(user) }

    it { is_expected.to change { session[:user_id] }.from(user.id).to(nil) }
  end
end
