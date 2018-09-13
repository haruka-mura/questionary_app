require 'rails_helper'

RSpec.describe Questions::AnswersController, type: :controller do
  describe "#new" do
    subject { get :new, params: { question_id: question.id } }
    let(:question) { create :question }

    context 'when user is logged_in' do
      before { session[:user_id] = user.id }

      let(:user) { create :user }

      it { is_expected.to have_http_status(:ok) }
    end

    context '' do
      it { is_expected.to redirect_to root_path }
    end
  end

  describe "#create" do
    subject { post :create, params: { answer: answer_params, question_id: question.id } }

    let(:user) { create :user }
    let(:question) { create :question }

    context 'ログインしている時' do
      before { session[:user_id] = user.id }

      context 'パラメータが有効な時' do
        let(:answer_params) { attributes_for :answer }

        it do
          expect { subject }.to change { Answer.count }.by(1)
          is_expected.to have_http_status(302)
        end
      end

      context 'パラメータが無効な時' do
        let(:answer_params) { attributes_for :answer, comment: "" }

        it do
          expect { subject }.not_to change { Answer.count }
          is_expected.to render_template :new
        end
      end
    end

    context 'ログインしていない時' do
      let(:answer_params) { attributes_for :answer }

      it { is_expected.to redirect_to root_path }
    end
  end
end
