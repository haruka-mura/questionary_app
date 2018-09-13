require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe '#index' do
    subject { get :index }

    before { session[:user_id] = user.id }

    let(:user) { create :user }

    it { is_expected.to have_http_status(:ok) }
  end

  describe '#new' do
    subject { get :new }

    before { session[:user_id] = user.id }

    let(:user) { create :user }

    it { is_expected.to have_http_status(:ok) }
  end

  describe '#show' do
    subject { get :show, params: { id: question_id } }

    before { session[:user_id] = user.id }

    let(:user) { create :user }

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

      it { is_expected.to redirect_to root_path }
    end
  end

  describe '#edit' do
    subject { get :edit, params: { id: question_id } }

    before { session[:user_id] = user.id }

    let(:user) { create :user }
    let(:question) { create :question }

    context 'パラメータが有効な時' do
      let(:question_id) { question.id }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'パラメータが無効な時' do
      let(:question_id) { 'aaa' }

      it { expect { subject }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe '#update' do
    subject { put :update, params: { id: question.id, question: question_params } }

    before { session[:user_id] = user.id }

    let(:user) { create :user }
    let(:question) { create :question }
    let(:question_params) { attributes_for :question, subject: new_subject }

    context 'パラメータが有効な時' do
      let(:new_subject) { "new subject" }

      it do
        expect { subject }.to change { question.reload.subject }.to(new_subject)
        is_expected.to redirect_to question
      end
    end

    context 'パラメータが無効な時' do
      let(:new_subject) { "" }

      it do
        expect { subject }.to_not change { question.reload.subject }
        is_expected.to render_template :edit
      end
    end
  end
end
