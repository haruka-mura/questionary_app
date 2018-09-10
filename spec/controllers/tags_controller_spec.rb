require 'rails_helper'

RSpec.describe TagsController, type: :controller do

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

    let!(:question) { create :question, tags: [tag1, tag2] }
    let(:tag1) { create :tag, name: "tag1" }
    let(:tag2) { create :tag, name: "tag2" }
    let(:tag_params) { { name: new_tags } }

    # createして配列にしてポイする

    context '新しいtagが1つ増えた時' do
      let(:new_tags) { "tag1 tag2 new_tag" }

      it do
        expect { subject }.to change { Tag.count }.from(2).to(3)
        is_expected.to redirect_to question
      end
    end

    context 'tagが1つも入力されない時' do
      let(:new_tags) { "" }

      it do
        expect { subject }.to change { question.tags.count }.by(-2)
        is_expected.to redirect_to question
      end
    end
  end
end
