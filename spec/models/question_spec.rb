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
end
