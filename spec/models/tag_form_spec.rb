require 'rails_helper'

RSpec.describe TagForm, type: :model do
  let(:question) { create :question }
  let(:tag_params) { attributes_for :tag }

  describe '#save' do
    subject { tag_form.save }

    let(:tag_form) { TagForm.new(tag_params.merge(question: question)) }

    it { expect { subject }.to change { Tag.count }.by(3) }
  end

  describe '#show_tags' do
    subject { tag_form.show_tags }

    before { TagForm.new(tag_params.merge(question: question)).save }

    let(:tag_form) { TagForm.new(question: question) }

    it { is_expected.to eq "tag1 tag2 tag3" }
  end
end
