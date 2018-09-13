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
  # 
  # describe '#current_user' do
  #   subject { helper.current_user }
  #
  #   let(:user) { create :user }
  #
  #   before { helper.log_in(user) }
  #
  #   it { is_expected.to eq user }
  # end
  #
  # describe '#logged_in?' do
  #   subject { helper.logged_in? }
  #
  #   context 'when user is logged_in' do
  #     let(:user) { create :user }
  #
  #     before { helper.log_in(user) }
  #
  #     it { is_expected.to be_truthy }
  #   end
  #
  #   context 'when user is not logged_in' do
  #     it { is_expected.to be_falsey }
  #   end
  # end
end
