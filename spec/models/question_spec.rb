require 'rails_helper'

RSpec.describe Question, type: :model do
  describe '#valid?' do
    subject { build :question, attributes }

    context 'パラメータが全て有効なとき' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end

    context 'subjectがないとき' do
      let(:attributes) { { subject: "" } }

      it { is_expected.to be_invalid }
    end

    context 'contentがないとき' do
      let(:attributes) { { content: "" } }

      it { is_expected.to be_invalid }
    end

    context 'subjectが200文字の時' do
      let(:attributes) { { subject: "a" * 200 } }

      it { is_expected.to be_valid }
    end

    context 'subjectが201文字の時' do
      let(:attributes) { { subject: "a" * 201 } }

      it { is_expected.to be_invalid }
    end
  end

  describe 'scope' do
    describe 'search_with_keyword' do
      subject { Question.search_with_keyword(keyword) }

      let(:question1) { create :question, subject: "subject_test" }
      let(:question2) { create :question, content: "content_test" }


      context 'subjectが検索に引っかかる時' do
        let(:keyword) { "subject" }

        it { is_expected.to include question1 }
      end

      context 'contentが検索に引っかかる時' do
        let(:keyword) { "content" }

        it { is_expected.to include question2 }
      end

      context 'subject, content両方の文字が検索に引っかかる時' do
        let(:keyword) { "test" }

        it { is_expected.to include question1, question2 }
      end

      context 'キーワードが検索に引っかからない時' do
        let(:keyword) { "object" }

        it { is_expected.not_to include question1, question2 }
      end

      context 'キーワードが "" の時' do
        let(:keyword) { "" }

        it { is_expected.to include question1, question2 }
      end
    end
  end
end
