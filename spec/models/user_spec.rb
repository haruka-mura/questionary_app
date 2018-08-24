require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do
    subject { build :user, attributes }

    context 'name, email, passwordがvalidなとき' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end

    context 'nameが存在しないとき' do
      let(:attributes) { { name: "" } }

      it { is_expected.to be_invalid }
    end

    context 'emailが存在しないとき' do
      let(:attributes) { { email: "" } }

      it { is_expected.to be_invalid }
    end

    context 'nameが20文字のとき' do
      let(:attributes) { { name: "a" * 20 } }

      it { is_expected.to be_valid }
    end

    context 'nameが21文字のとき' do
      let(:attributes) { { name: "a" * 21 } }

      it { is_expected.to be_invalid }
    end

    context 'emailが255文字のとき' do
      let(:attributes) { { email: "a" * 244 + "@sample.com" } }

      it { is_expected.to be_valid }
    end

    context 'emailが256文字のとき' do
      let(:attributes) { { email: "a" * 245 + "@sample.com" } }

      it { is_expected.to be_invalid }
    end

    context 'emailが重複したとき' do
      let(:attributes) { { email: "TEST@example.com" } }
      before { create :user , { email: "TEST@example.com" }}

      it { is_expected.to be_invalid }
    end

    context 'emailのフォーマットが正しくないとき' do
      let(:attributes) { { email: "TEST@@example.com" } }

      it { is_expected.to be_invalid }
    end

    # "TEST@@example.com.com"の時のテスト

    context 'passwordが6文字のとき' do
      let(:attributes) { { password: "a" * 6, password_confirmation: "a" * 6 } }

      it { is_expected.to be_valid }
    end

    context 'passwordが5文字のとき' do
      let(:attributes) { { password: "a" * 5, password_confirmation: "a" * 5 } }

      it { is_expected.to be_invalid }
    end
  end
end
