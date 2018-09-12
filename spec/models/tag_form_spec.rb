require 'rails_helper'

RSpec.describe TagForm, type: :model do
  describe '#save' do
    subject { tag_form.save }

    let(:question) { create :question }
    let(:tag_params) { attributes_for :tag }
    let(:tag_form) { TagForm.new(tag_params.merge(question: question)) }

    it { expect { subject }.to change { Tag.count }.by(1) }
  end

  describe '#show_tags' do
    let!(:question) { create :question, tags: [tag1, tag2] }
    let(:tag1) { create :tag, name: "tag1" }
    let(:tag2) { create :tag, name: "tag2" }
    let(:tag_form) { TagForm.new(question: question) }

    subject { tag_form.show_tags }

    it { is_expected.to eq "tag1 tag2" }
  end
end
