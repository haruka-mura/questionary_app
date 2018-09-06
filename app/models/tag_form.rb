class TagForm
  include ActiveModel::Model
  attr_accessor :name, :question

  def save
    tag = Tag.new(name: name)
    question.tags << tag
    tag.save
  end

  def update
    true
  end

  def show_tags
    "success update"
  end
end
