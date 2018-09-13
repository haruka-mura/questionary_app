require 'rails_helper'

RSpec.describe TopController, type: :controller do
  describe '#index' do
    subject { get :index }

    context 'when user is logged_in' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }

      it { is_expected.to redirect_to questions_path }
    end

    context 'when user is not logged_in' do
      it { is_expected.to have_http_status(:ok) }
    end
  end
end
