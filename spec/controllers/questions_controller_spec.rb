require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe '#index' do
    subject { get :index }

    it { is_expected.to have_http_status(:ok) }
  end

  describe '#new' do
    subject { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe '#show' do
    subject { get :show, params: { id: question_id } }

    context 'パラメータが有効なとき' do
      let(:question) { create :question }
      let(:question_id) { question.id }

      it do
        is_expected.to have_http_status(:ok)
        expect(assigns(:question)).to eq question
      end
    end

    context 'パラメータが無効なとき' do
      let(:question_id) { 'aaa' }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe '#create' do
    subject { post :create, params: { question: question_params } }

    let(:user) { create :user }

    context 'ログインしているとき' do
      context 'パラメータが有効なとき' do
        let(:question_params) { attributes_for :question }

        before { session[:user_id] = user.id }

        it do
          expect { subject }.to change { Question.count }.by(1)
          is_expected.to redirect_to Question.last
        end
      end

      context 'パラメータが無効なとき' do
        let(:question_params) { attributes_for :question, subject: "" }

        before { session[:user_id] = user.id }

        it do
          expect { subject }.not_to change { Question.count }
          is_expected.to render_template :new
        end
      end
    end

    context 'ログインしていないとき' do
      let(:question_params) { attributes_for :question }

      it { is_expected.to render_template :new }
    end
  end
end
