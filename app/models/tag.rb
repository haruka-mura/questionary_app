class Tag < ApplicationRecord
  has_many :question_tags
  has_many :questions, through: :question_tags

  def show_tags
    @tags = []
    self.each do |tag|
      @tags << tag.name
    end
    @tags.first
  end
end
