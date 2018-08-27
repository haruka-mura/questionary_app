require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe '#create' do
    subject { post :create, params: { session: user_params } }
    let(:user) { create :user }

    context 'email, passwordが有効なとき' do
      let(:user_params) { { email: user.email, password: user.password } }

      it { is_expected.to redirect_to user }
    end

    context 'emailが無効なとき' do
      let(:user_params) { { email: 'test@sample.com', password: user.password } }

      it { is_expected.to redirect_to login_path }
    end

    context 'passwordが無効なとき' do
      let(:user_params) { { email: user.email, password: 'password' } }

      it { is_expected.to redirect_to login_path }
    end
  end

  describe '#destroy' do
    subject { get :destroy }

    it { is_expected.to redirect_to root_path }
  end
end
