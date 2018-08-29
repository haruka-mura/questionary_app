require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe "#valid?" do
    subject { build :answer, attributes }

    context 'パラメータが有効な時' do
      let(:attributes) { {} }

      it { is_expected.to be_valid }
    end

    context 'commentが無効な時' do
      let(:attributes) { { comment: "" } }

      it { is_expected.to be_invalid }
    end
  end
end
