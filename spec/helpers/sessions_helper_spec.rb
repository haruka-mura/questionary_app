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

  # describe '#current_user' do
  #   let(:user) { create :user }
  #
  #   before do
  #     helper.log_in(user)
  #     helper.current_user
  #   end
  #
  #   it { expect(assigns(:current_user)).to eq user }
  # end

  # describe '#logged_in?' do
  #
  # end
end
