require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe '#show' do
    subject { get :show, params: { id: user.id } }

    let(:user) { create :user }

    context 'when user is logged_in' do
      before { session[:user_id] = user.id }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when user is not logged_in' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe '#create' do
    subject { proc { post :create, params: { user: user_params } } }

    context "with valid params" do
      let(:user_params) { attributes_for :user }

      it "creates a new User" do
        is_expected.to change { User.count }.by(1)
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid params" do
      let(:user_params) { attributes_for :user, name: "" }

      it do
        is_expected.not_to change { User.count }
        expect(response).to render_template :new
      end
    end
  end
end
