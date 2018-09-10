class TagForm
  include ActiveModel::Model
  attr_accessor :name, :question

  def save
    tags = name.split(/\s|　/)

    new_tags = tags.map do |tag|
      Tag.find_or_create_by(name: tag)
    end
    question.tags = new_tags
  end

  def show_tags
    question.tags.map(&:name).join(" ")
  end
end
