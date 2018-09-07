require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  describe '#new' do
    subject { get :new, params: { question_id: question.id } }

    let(:question) { create :question }
    it { is_expected.to have_http_status(:ok) }
  end

  describe '#create' do
    subject { post :create, params: { tag_form: tag_params, question_id: question.id } }
    let(:question) { create :question }

    context 'パラメータが有効な時' do
      let(:tag_params) { attributes_for :tag }

      it do
        expect { subject }.to change { Tag.count }.by(3)
        is_expected.to have_http_status(302)
      end
    end

    context 'パラメータが無効な時' do
      # tag_paramsが無効な時ってどんな時...?
      # question_idが無効なケースもいる？
      let(:tag_params) { attributes_for :tag, name: "" }
    end
  end

  describe '#edit' do
    subject { get :edit, params: { id: question_id } }

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
    subject { put :update, params: { tag_form: tag_params, id: question.id } }
    let(:question) { create :question }
    let(:tag) { create :tag }
    let(:tag_params) { attributes_for :tag, name: new_tags }

    context 'tagが1つ減った時' do
      let(:new_tags) { "tag1 tag2" }

      it do
        expect { subject }.to change { Tag.count }.by(2)
        is_expected.to redirect_to question
      end
    end

    context '新しいtagが1つ増えた時' do
      let(:new_tags) { "tag1 tag2 tag3 tag4" }

      it do
        expect { subject }.to change { Tag.count }.by(4)
        is_expected.to redirect_to question
      end
    end
  end
end
